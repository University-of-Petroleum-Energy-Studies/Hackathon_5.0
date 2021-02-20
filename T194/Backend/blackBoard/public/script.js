const socket = io.connect("http://localhost:3000");
socket.on("jediStream", (data) => {
  const bbCanVasObj = document.getElementById("bbCanvas");
  bbCanVasObj.src = `data:image/jpeg;base64,${data}`;
});
