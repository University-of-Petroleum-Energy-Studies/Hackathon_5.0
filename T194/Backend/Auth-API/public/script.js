const nameField = document.querySelector(".userEmail");
const passField = document.querySelector(".userPass");
const loginReq = document.getElementById("submit");

loginReq.addEventListener("click", async () => {
  const userName = nameField.value;
  const userPass = passField.value;
  fetch("/user/login", {
    method: "POST",
    credentials: "same-origin",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      username: userName,
      password: userPass,
    }),
  })
    .then((res) => res.json())
    .then((processedData) => {
      if (processedData.status === "denied") {
        // Authentication unsuccessful.
        alert(processedData.message);
        window.location.reload();
      }
      //Save JWT for further Auth-session.
      localStorage.setItem(
        "jediAuth",
        JSON.stringify(processedData.result.user.JWT)
      );

      // Send JWT signed request, to enter into landing page.
      fetch("/", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authentication: `Bearer ${processedData.result.user.JWT}`,
        },
        body: JSON.stringify({ username: processedData.result.user.name }),
      })
        .then((res) => res.json())
        .then((parsedData) => {
          console.log(parsedData);
          window.open("/home", "_self");
        });
    })
    .catch((err) => {
      console.error(err);
    });
});
