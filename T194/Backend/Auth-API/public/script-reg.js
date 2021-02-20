// loginReq.addEventListener("click", async () => {
//   const userName = nameField.value;
//   const userPass = passField.value;
//   const email = emailField.value;
//   const fullname = fullName.value;
//   const phoneno = phoneNo.value;
//   var usertype = userType.value;
//   if (usertype === "faculty") {
//     usertype = true;
//   } else {
//     usertype = false;
//   }

//   fetch("/user/register", {
//     method: "POST",
//     credentials: "same-origin",
//     headers: {
//       "Content-Type": "application/json",
//     },
//     body: JSON.stringify({
//       username: userName,
//       password: userPass,
//       email: email,
//       fullname: fullname,
//       phoneno: phoneno,
//       usertype: usertype,
//     }),
//   })
//     .then((res) => res.json())
//     .then((processedData) => {
//       alert(processedData.message);
//       if (processedData.status === "ok") {
//         window.open("http://localhost:3000/login", "_self");
//       }
//     })
//     .catch((err) => {
//       console.error(err);
//     });
// });
