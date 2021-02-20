const cv = require("opencv4nodejs");
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
    res.render("bb");

    // OpenCV way to access camStream from front-end.
    const FPS = 30;
    const vCap = new cv.VideoCapture(0);
    vCap.set(cv.CAP_PROP_FRAME_WIDTH, 320);
    vCap.set(cv.CAP_PROP_FRAME_HEIGHT, 240);
    setInterval(() => {
      const frame = vCap.read(); // vCap.read() returns mat obj.
      // Encode mat obj into base64 encoding, for io transmission.
      // Listen for the "jediStream" event on frontend socket.
      const image = cv.imencode(".jpeg", frame).toString("base64");
      io.emit("jediStream", image);
    }, 1000 / FPS);
  });
}

initBlackboard();
