// use uuid to generate unique id.

// Import env config,
require("dotenv").config();

// Import express
const express = require("express");

// Import postgreSQL client
const { Pool } = require("pg");
const { resourceUsage, nextTick } = require("process");
const pool = new Pool({
  connectionString: "postgresql://postgres:jedi1234@0.0.0.0:5432/jedi",
});

// Password hashing+salting
const bcrypt = require("bcryptjs");

// Handling JSON
const { json } = require("express");

//Imoort path
const path = require("path");

// Create an instance of express (Start the server)
const app = express();
const server = require("http").Server(app);
app.use(express.json()); // Enables to accept JSON requests.
app.use("/", express.static(path.join(__dirname, "public"))); // Exposed to public.
app.set("view engine", "ejs");
app.use(express.urlencoded({ extended: false }));

// JWT integration
const jwt = require("jsonwebtoken");

// Start listening to PORT 3000.
const PORT = 3000;
const HOST_URL = `http://localhost:${PORT}`;
server.listen(PORT);
console.log(`running on ${HOST_URL}/registration`);
console.log(`running on ${HOST_URL}/login`);

async function init() {
  // ******************************************* GETS DATA FROM postgreSQL DB **************************************************
  app.post(
    "/",
    async (req, res, next) => {
      //Middle-Ware Authentication.
      console.log("Auth API requested.");
      const authHeader = req.headers["authentication"];
      const token = authHeader && authHeader.split(" ")[1];

      if (token === null) {
        res.status(401).redirect("/login");
      }

      var result;
      try {
        const client = await pool.connect();
        result = await Promise.all([
          client.query("SELECT loginpassword FROM users WHERE username=$1", [
            req.body.username,
          ]),
        ]);
      } catch (err) {
        console.log("Error ********* Fetching from postgreSQL");
        console.error(err);
        res.status(401).redirect("/login");
      }
      const loginPass = result[0].rows[0].loginpassword;
      jwt.verify(token, loginPass, (err, userInfo) => {
        if (err) return res.status(401).redirect("/login");
        req.user = userInfo;
        next(); //Route if authorized.
      });
    },
    (req, res) => {
      console.log(`Logged in as, ${req.user.userName}`);
      res.status(200).json({
        code: 200,
        status: "ok",
        message: "Successfully signed JWT",
      });
    }
  );

  app.get("/home", (req, res) => {
    res.render("index");
  });

  app.get("/login", (req, res) => {
    res.render("login");
  });

  app.get("/registration", (req, res) => {
    res.render("reg");
  });

  async function GET_psql(query) {
    try {
      const client = await pool.connect();
      const [result] = await Promise.all([client.query(`${query}`)]);
      return result.rows;
    } catch (err) {
      console.log("Error ********* Fetching from postgreSQL");
      console.log(err);
    }
  }

  // ******************************************** POSTS DATA INTO postgreSQL DB **************************************************
  async function POST_psql(query) {
    try {
      const client = await pool.connect();
      await Promise.all([client.query(`${query}`)]);
    } catch (err) {
      console.log(`Error ********* Failed posting into postgreSQL`);
      console.log(err);
    }
  }

  //   *************************************SERVES REGISTRATION FUNCTIONALITY.*****************************************************************

  app.post("/user/register", async (req, res) => {
    const USER_TYPE = req.body.usertype === "student" ? false : true;
    try {
      bcrypt.genSalt(10, async (err, salt) => {
        bcrypt.hash(
          req.body.password,
          salt,
          async function (err, hashedPassword) {
            // Password hashed.
            const client = await pool.connect();
            await Promise.all([
              client.query(
                // Run query via pg-client js.
                "INSERT INTO users (username, loginpassword, fullname, phoneno, usertype) VALUES ($1, $2, $3, $4, $5)",
                [
                  req.body.username,
                  hashedPassword,
                  req.body.fullname,
                  req.body.phoneno,
                  USER_TYPE,
                ]
              ),
            ]);
          }
        );
      });
      res.status(200).redirect("/login");
    } catch (err) {
      console.error(err);
      res.status(401).redirect("/registration");
    }
  });

  //   *************************************SERVES LOGIN FUNCTIONALITY.*****************************************************************
  app.post("/user/login", async (req, res) => {
    //Look for username in database, if found fetch password and user_id.
    try {
      const client = await pool.connect();
      const [result] = await Promise.all([
        client.query(
          "SELECT user_id, loginPassword, username, userType FROM users WHERE username=$1",
          [req.body.username]
        ),
      ]);
      const user = result.rows[0];
      if (user === null) {
        res
          .status(400)
          .json({
            status: "denied",
            code: 401,
            message: "User not registered!",
          })
          .end();
        return;
      }

      try {
        bcrypt.compare(
          req.body.password, // Entered Password
          user.loginpassword, // Password extracted from database.
          function (err, match) {
            if (match) {
              const jwtPayload = {
                // Payload configuration.
                userId: user.user_id,
                userType: user.usertype,
                userName: user.username,
              };
              const JWtoken = jwt.sign(jwtPayload, user.loginpassword);
              // Send OK status in requested format. [Succesfull authentication]
              console.log("Credentials Verified");
              res
                .status(200)
                .json({
                  status: "ok",
                  code: "200",
                  error: [],
                  message: "Credentials authentication successful.",
                  result: {
                    user: {
                      id: user.user_id,
                      name: user.username,
                      JWT: JWtoken,
                    },
                  },
                })
                .end();
            } else {
              res
                .json({
                  status: "denied",
                  code: 401,
                  message: "Incorrect password.",
                })
                .end();
            }
          }
        );
      } catch (err) {
        //send error details.
        console.log("error", err);

        res
          .status(404)
          .json({
            status: "failed",
            code: "404",
            error: err,
            message: "Server down, try again later.",
            result: {
              user: {},
            },
          })
          .end();
      }
    } catch (err) {
      console.log("Error ********* Fetching from postgreSQL");
      console.log(err);
      res
        .json({
          status: "denied",
          code: 500,
          message: "Database down, try again later.",
        })
        .end();
    }
  });

  //******************************* SERVICES WITH AUTHENTICITY CHECK******************* */
}

init();
