import 'package:hackathon/screens/loginpage.dart';
import 'package:hackathon/screens/mainpage1.dart';
import 'package:hackathon/widgets/widgets.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackathon/widgets/ProgressDialog.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = 'register';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title) {
    final snackbar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    scaffoldkey.currentState.showSnackBar(snackbar);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var fullNameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  void registerUser() async {
    // showing progess activity indicator
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          ProgressDialog(status: 'Registering You'),
    );
    // firebase service to create a user  with email and password
    final user = (await _auth
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .catchError((ex) {
      // if found error
      Navigator.pop(context);
      PlatformException thisEx = ex;
      showSnackBar(thisEx.message);
    }))
        .user;

    if (user != null) {
      DatabaseReference newUserRef =
          FirebaseDatabase.instance.reference().child('users/${user.uid}');

      // data saved into the users table
      Map userMap = {
        'fullname': fullNameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
      };

      newUserRef.set(userMap);

      // taking user  to  the mainPage

      Navigator.pushNamedAndRemoveUntil(
          context, MainPage1.id, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldkey,
        appBar: AppBar(
          title: appBar(context),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          brightness: Brightness.light,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            ClipOval(
              child: Image(
                image: AssetImage('images/runtime.png'),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Create Your Account',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Brand-Bold',
                  color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: fullNameController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Full name",
                      hintStyle: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black87),
                          borderRadius: BorderRadius.circular(16)),
                      prefixIcon: const Icon(
                        Icons.text_fields,
                        color: Colors.purpleAccent,
                      ),
                    ),
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: emailController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Email address",
                        hintStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black87,
                            ),
                            borderRadius: BorderRadius.circular(16)),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.purpleAccent,
                        )),
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Phone number",
                      hintStyle: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black87),
                          borderRadius: BorderRadius.circular(16)),
                      prefixIcon: const Icon(
                        Icons.phone_iphone_rounded,
                        color: Colors.purpleAccent,
                      ),
                    ),
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black87,
                            ),
                            borderRadius: BorderRadius.circular(16)),
                        prefixIcon: const Icon(
                          Icons.security,
                          color: Colors.purpleAccent,
                        )),
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: RaisedButton(
                  onPressed: () async {
                    // we have to  check  for the network  availability

                    var connectivityResult =
                        await Connectivity().checkConnectivity();
                    if (connectivityResult != ConnectivityResult.mobile &&
                        connectivityResult != ConnectivityResult.wifi) {
                      showSnackBar("No internet connection");
                      return;
                    }

                    if (fullNameController.text.length < 3) {
                      showSnackBar("Provide valid name");
                      return;
                    }
                    if (phoneController.text.length < 10) {
                      showSnackBar("Provide valid phone number");
                      return;
                    }
                    if (!emailController.text.contains('@')) {
                      showSnackBar("Provide valid email address");
                      return;
                    }
                    if (passwordController.text.length < 8) {
                      showSnackBar("Provide atleast 8 digit password");
                      return;
                    }
                    registerUser();
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(130),
                  ),
                  color: Colors.purpleAccent,
                  textColor: Colors.black,
                  child: Container(
                    height: 50,
                    child: Center(
                      child: Text(
                        'Sign Up',
                        style:
                            TextStyle(fontSize: 18, fontFamily: 'Brand-Bold'),
                      ),
                    ),
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                    style: TextStyle(fontSize: 15.5, color: Colors.black)),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginPage.id, (route) => false);
                    },
                    child: Text("  Log in",
                        style: TextStyle(
                            fontSize: 16.5,
                            color: Colors.purple,
                            decoration: TextDecoration.underline)))
              ],
            ),
          ],
        )));
  }
}
