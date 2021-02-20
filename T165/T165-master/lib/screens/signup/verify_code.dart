import 'package:WSHCRD/common/locatization.dart';
import 'package:WSHCRD/firebase_services/auth_controller.dart';
import 'package:WSHCRD/utils/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';

class VerifyCode extends StatefulWidget {
  String verificationId;
  String phoneNo;
  String interPhoneNo;
  String isoCode;
  Function onVerify;
  Function onPhoneAuthComplete;
  VerifyCode(
      {Key key,
      this.phoneNo,
      this.interPhoneNo,
      this.isoCode,
      this.onVerify,
      this.onPhoneAuthComplete})
      : super(key: key);

  @override
  _VerifyCodeState createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final focusCode1 = FocusNode();
  final focusCode2 = FocusNode();
  final focusCode3 = FocusNode();
  final focusCode4 = FocusNode();
  final focusCode5 = FocusNode();
  final focusCode6 = FocusNode();
  final formKey = new GlobalKey<FormState>();
  String pin1;
  String pin2;
  String pin3;
  String pin4;
  String pin5;
  String pin6;
  String verificationCode;
  TextEditingController pin1Controller = new TextEditingController();
  TextEditingController pin2Controller = new TextEditingController();
  TextEditingController pin3Controller = new TextEditingController();
  TextEditingController pin4Controller = new TextEditingController();
  TextEditingController pin5Controller = new TextEditingController();
  TextEditingController pin6Controller = new TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      sendOTP(fistTime: true);
    });
    super.initState();
  }

  Future<void> sendOTP({bool fistTime = false}) async {
    showLoadingScreen();
    if (widget.interPhoneNo.length == 0) {
      Global.showToastMessage(
          context: context,
          msg: AppLocalizations.of(context).translate('invalid_phone_number'));
      return;
    }

    await AuthController.requestPhoneAuthentication(
        // Request Phone Authenticatin again
        phoneNo: widget.interPhoneNo,
        onSuccess: (verId) {
          widget.verificationId = verId;
          closeLoadingScreen();
          String message = 'OTP Code Sent to ${widget.interPhoneNo} ' +
              (fistTime ? '' : 'again');
          Global.showToastMessage(context: context, msg: message);
        },
        onVerificationCompleted: widget.onPhoneAuthComplete,
        onFailure: (AuthException error) {
          print(error.message);
          closeLoadingScreen();
          Global.showToastMessage(context: context, msg: error.message);
        }).catchError((error) {
      closeLoadingScreen();
      Global.showToastMessage(context: context, msg: error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              AppLocalizations.of(context).translate('enter_verification_code'),
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Card(
            //widget.phoneNo
            elevation: 10,
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: InternationalPhoneInput(
                decoration: InputDecoration.collapsed(
                  border: InputBorder.none,
                  hintText: widget.phoneNo,
                  hintStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w700,
                  ),
                  enabled: false,
                ),
                initialSelection: widget.isoCode,
                showCountryFlags: false,
                dropdownIcon: Row(
                  children: [
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    )
                  ],
                ),
                labelStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w700),
                hintStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Form(
            // Form for SMS Code
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    textInputAction: TextInputAction.next,
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    controller: pin1Controller,
                    focusNode: focusCode1,
                    onChanged: (value) {
                      setState(() {
                        pin1 = pin1Controller.text;
                        widget.onVerify(pin1, pin2, pin3, pin4, pin5, pin6,
                            widget.verificationId);
                      });
                      FocusScope.of(context).requestFocus(focusCode2);
                    },
                    decoration: InputDecoration(
                      counterText: "",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1), shape: BoxShape.circle),
                ),
                Container(
                  width: 50,
                  height: 50,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    textInputAction: TextInputAction.next,
                    focusNode: focusCode2,
                    controller: pin2Controller,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        pin2 = pin2Controller.text;
                        widget.onVerify(pin1, pin2, pin3, pin4, pin5, pin6,
                            widget.verificationId);
                      });
                      if (value.length == 1) {
                        FocusScope.of(context).requestFocus(focusCode3);
                      } else if (value.length == 0) {
                        setState(() {});
                        FocusScope.of(context).requestFocus(focusCode1);
                      }
                    },
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      counterText: "",
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1), shape: BoxShape.circle),
                ),
                Container(
                  width: 50,
                  height: 50,
                  child: TextFormField(
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    focusNode: focusCode3,
                    controller: pin3Controller,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).requestFocus(focusCode4);
                        setState(() {
                          pin3 = pin3Controller.text;
                          widget.onVerify(pin1, pin2, pin3, pin4, pin5, pin6,
                              widget.verificationId);
                        });
                      } else {
                        FocusScope.of(context).requestFocus(focusCode2);
                      }
                    },
                    decoration: InputDecoration(
                      counterText: "",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1), shape: BoxShape.circle),
                ),
                Container(
                  width: 50,
                  height: 50,
                  child: TextFormField(
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    focusNode: focusCode4,
                    controller: pin4Controller,
                    onChanged: (value) {
                      if (value.length == 1) {
                        setState(() {
                          pin4 = pin4Controller.text;
                          widget.onVerify(pin1, pin2, pin3, pin4, pin5, pin6,
                              widget.verificationId);
                        });
                        FocusScope.of(context).requestFocus(focusCode5);
                      } else if (value.length == 0) {
                        FocusScope.of(context).requestFocus(focusCode3);
                      }
                    },
                    decoration: InputDecoration(
                      counterText: "",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1), shape: BoxShape.circle),
                ),
                Container(
                  width: 50,
                  height: 50,
                  child: TextFormField(
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    focusNode: focusCode5,
                    controller: pin5Controller,
                    onChanged: (value) {
                      if (value.length == 1) {
                        setState(() {
                          pin5 = pin5Controller.text;
                          widget.onVerify(pin1, pin2, pin3, pin4, pin5, pin6,
                              widget.verificationId);
                        });
                        FocusScope.of(context).requestFocus(focusCode6);
                      } else {
                        FocusScope.of(context).requestFocus(focusCode4);
                      }
                    },
                    decoration: InputDecoration(
                      counterText: "",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1), shape: BoxShape.circle),
                ),
                Container(
                  width: 50,
                  height: 50,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    focusNode: focusCode6,
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    controller: pin6Controller,
                    onChanged: (value) {
                      setState(() {
                        pin6 = pin6Controller.text;
                        widget.onVerify(pin1, pin2, pin3, pin4, pin5, pin6,
                            widget.verificationId);
                      });
                      if (value.length != 1) {
                        FocusScope.of(context).requestFocus(focusCode5);
                      }
                    },
                    decoration: InputDecoration(
                      counterText: "",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1), shape: BoxShape.circle),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 10, right: 10, top: 20),
            child: MaterialButton(
              onPressed: () {
                // Resend OTP Code to phone
                sendOTP();
              },
              height: 50,
              child: Text(
                AppLocalizations.of(context).translate('resend_code'),
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
