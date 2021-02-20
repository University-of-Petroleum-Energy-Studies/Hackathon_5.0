const socket = io.connect("http://localhost:3000");
socket.on("image", (data) => {
  console.log("data", data);
});
