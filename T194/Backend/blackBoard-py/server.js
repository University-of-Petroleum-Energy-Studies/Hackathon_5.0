const path = require("path");
const express = require("express");
// Create an instance of express (Start the server)
const app = express();
const server = require("http").Server(app);
const io = require("socket.io")(server);
app.use(express.json()); // Enables to accept JSON requests.
app.use("/", express.static(path.join(__dirname, "public"))); // Exposed to public.
app.set("view engine", "ejs");

const PORT = 3000;
const HOST_URL = `http://localhost:${PORT}`;
server.listen(PORT);
console.log(`running on ${HOST_URL}`);

function initBlackboard() {
  app.get("/", (req, res) => {
    res.render("bb-test");
  });

  setInterval(() => {
    io.emit("image", "some data");
  }, 1000);
}

initBlackboard();
