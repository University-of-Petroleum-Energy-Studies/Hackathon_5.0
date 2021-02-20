import 'package:WSHCRD/firebase_services/auth_controller.dart';
import 'package:WSHCRD/screens/start.dart';
import 'package:WSHCRD/utils/session_controller.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class ProfileMiscInfo extends StatelessWidget {
  const ProfileMiscInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        MaterialButton(
          padding: EdgeInsets.all(10),
          onPressed: () {
            //TODO
          },
          child: Row(
            children: <Widget>[
              Icon(Icons.email, size: 30),
              SizedBox(
                width: 20,
              ),
              Text(
                "Contact us",
                style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: Colors.black, width: 1),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        MaterialButton(
          padding: EdgeInsets.all(10),
          onPressed: () async {
            logOutAndReturnToLoginScreen(context);
          },
          child: Row(
            children: <Widget>[
              Icon(Icons.exit_to_app, size: 30),
              SizedBox(
                width: 20,
              ),
              Text(
                "Log out",
                style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: Colors.black, width: 1),
          ),
        ),
      ],
    );
  }

  Future<void> logOutAndReturnToLoginScreen(BuildContext context) async {
    await AuthController.logoutUser();
    await SessionController.clearSession();
    BotToast.showText(text: "User logged out successfully");
    Navigator.pushNamedAndRemoveUntil(
      context,
      Start.routeName,
      (Route<dynamic> route) => false,
    );
  }
}
