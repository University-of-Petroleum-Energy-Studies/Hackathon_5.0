import 'dart:async';

import 'package:WSHCRD/common/locatization.dart';
import 'package:WSHCRD/screens/signup/signup_screen.dart';
import 'package:WSHCRD/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';

class Start extends StatefulWidget {
  static const routeName = "/";

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  String internationalizedPhoneNumber;
  String phoneNumber = "";
  String isoCode = "";

  @override
  void initState() {
    super.initState();
  }

  Future<void> sendOTP() async {
    // Send OTP Code to your phone
    if (internationalizedPhoneNumber.length == 0) {
      Global.showToastMessage(
        context: context,
        msg: AppLocalizations.of(context).translate("invalid_phone_number"),
      );
      return;
    } else {
      Navigator.pushNamed(
        context,
        SignUpScreen.routeName,
        arguments: {
          'phoneNo': phoneNumber,
          'interPhoneNo': internationalizedPhoneNumber,
          'isoCode': isoCode
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Center(
                  child: Image.asset('assets/logo.jpg'),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter your Phone",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "number to",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "continue.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.black, width: 2),
                  left: BorderSide(color: Colors.black, width: 2),
                  right: BorderSide(color: Colors.black, width: 2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 60,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 8,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: Color(0xffFFF34E), width: 4),
                              ),
                            ),
                            child: InternationalPhoneInput(
                              dropdownIcon: Row(
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  )
                                ],
                              ),
                              decoration: InputDecoration.collapsed(
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 3,
                                ),
                                hintText: "55555 55555",
                              ),
                              labelStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.black.withOpacity(0.5),
                                fontWeight: FontWeight.w700,
                                letterSpacing: 3,
                              ),
                              showCountryFlags: false,
                              initialPhoneNumber: phoneNumber,
                              onPhoneNumberChange: (_number,
                                  _internationalizedPhoneNumber, _isoCode) {
                                phoneNumber = _number;

                                internationalizedPhoneNumber =
                                    _internationalizedPhoneNumber;
                                isoCode = _isoCode;
                              },
                              initialSelection: "in",
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: sendOTP,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffFFF34E),
                      ),
                      margin: EdgeInsets.only(right: 20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      child: Text(
                        "Lets' go",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
