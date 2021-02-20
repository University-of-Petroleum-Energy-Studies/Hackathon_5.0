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
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
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
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Card(
                  shadowColor: Colors.grey,
                  elevation: 10,
                  child: Container(
                    height: 60,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          flex: 7,
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: InternationalPhoneInput(
                              dropdownIcon: Row(
                                children: <Widget>[
                                  Icon(Icons.arrow_drop_down),
                                  VerticalDivider(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                              decoration: InputDecoration.collapsed(
                                  hintText: AppLocalizations.of(context)
                                      .translate('enter_number'),
                                  hintStyle: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700)),
                              initialPhoneNumber: phoneNumber,
                              onPhoneNumberChange: (_number,
                                  _internationalizedPhoneNumber, _isoCode) {
                                print(
                                    "internationalizedPhoneNumber $internationalizedPhoneNumber");

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
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              sendOTP();
                            },
                            child: Icon(
                              Icons.arrow_forward,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
