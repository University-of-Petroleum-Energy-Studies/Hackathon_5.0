import 'package:WSHCRD/common/locatization.dart';
import 'package:WSHCRD/firebase_services/auth_controller.dart';
import 'package:WSHCRD/firebase_services/owner_controller.dart';
import 'package:WSHCRD/models/customer.dart';
import 'package:WSHCRD/models/owner.dart';
import 'package:WSHCRD/screens/customer/home/customer_home.dart';
import 'package:WSHCRD/screens/owner/owner_home_screen.dart';
import 'package:WSHCRD/screens/signup/business_name.dart';
import 'package:WSHCRD/screens/signup/business_or_customer.dart';
import 'package:WSHCRD/screens/signup/customer/customer_display_name.dart';
import 'package:WSHCRD/screens/signup/shop_location.dart';
import 'package:WSHCRD/screens/signup/verify_code.dart';
import 'package:WSHCRD/utils/global.dart';
import 'package:WSHCRD/utils/session_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SignUpScreen extends StatefulWidget {
  String verificationId;
  String phoneNo;
  String interPhoneNo;
  String isoCode;

  static const routeName = 'SignUpScreen';

  setValues(Map<String, dynamic> values) {
    this.phoneNo = values['phoneNo'];
    this.interPhoneNo = values['interPhoneNo'];
    this.isoCode = values['isoCode'];
  }

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  int indicatorCurrentStep;
  int stepperCurrentStep;
  List<Widget> steps = [];
  int verifyStatus;
  String smsCode;
  int isBusiness;
  String businessName;
  String category;
  String customerDisplayName;
  String uid;
  Owner owner;
  Customer customer;

  @override
  void initState() {
    super.initState();
    owner = Owner();
    customer = Customer();
    indicatorCurrentStep = 20;
    stepperCurrentStep = 0;
    steps = [
      VerifyCode(
          phoneNo: widget.phoneNo,
          interPhoneNo: widget.interPhoneNo,
          isoCode: widget.isoCode,
          onPhoneAuthComplete: (dynamic authCredential) {
            // this will enable the auto receiving sms part
            verifyPhoneNumber(phoneAuthCredential: authCredential);
          },
          onVerify: (pin1, pin2, pin3, pin4, pin5, pin6, verificationId) {
            widget.verificationId = verificationId;
            if (pin1 != null &&
                pin2 != null &&
                pin3 != null &&
                pin4 != null &&
                pin5 != null &&
                pin6 != null) {
              setState(() {
                smsCode = pin1 + pin2 + pin3 + pin4 + pin5 + pin6;
              });
            }
          }),
      BusinessOrCustomer(businessOrNot: (_isBusiness) {
        // Identify if business or customer
        setState(() {
          isBusiness = _isBusiness;
        });
        if (_isBusiness == 1) {
          setState(() {
            indicatorCurrentStep = 80;
            stepperCurrentStep = 3;
          });
        } else {
          setState(() {
            indicatorCurrentStep = 100;
            stepperCurrentStep = 2;
          });
        }
      }),
      CustomerDisplayName(customerDisplayName: (_customerDisplayName) {
        // Get Customer Display Name
        setState(() {
          customerDisplayName = _customerDisplayName;
        });
      }),
      BusinessName(businessNameAndCategory: (_businessName, _category) {
        // Get Business Name and Category
        setState(() {
          businessName = _businessName;
          category = _category;
        });
      }),
      ShopLocation(getShopLocation: (PickResult _pickResult) {
        owner.location = GeoFirePoint(_pickResult.geometry.location.lat,
            _pickResult.geometry.location.lng);
        owner.address = _pickResult.formattedAddress;
      }),
    ];
  }

  phoneVerify() {
    if (smsCode == null || smsCode.isEmpty || smsCode.length != 6) {
      Global.showToastMessage(
          context: context,
          msg: AppLocalizations.of(context).translate('invalid_otp'));
    } else {
      showLoadingScreen();
      verifyPhoneNumber(
          smsCode: smsCode, verificationId: widget.verificationId);
    }
  }

  verifyPhoneNumber(
      {verificationId: String, smsCode: String, phoneAuthCredential}) async {
    AuthCredential credential;
    /* closeLoadingScreen();
    setState(() {
      stepperCurrentStep = 1;
      indicatorCurrentStep = 40;
    });
    return;*/
    if (phoneAuthCredential != null) {
      credential = phoneAuthCredential;
    } else {
      credential = PhoneAuthProvider.getCredential(
          verificationId: verificationId, smsCode: smsCode);
    }

    await FirebaseAuth.instance.signInWithCredential(credential).then((user) {
      FirebaseAuth.instance.currentUser().then((user) async {
        closeLoadingScreen();
        setState(() {
          uid = user.uid;
        });
        // Check if the phone number is already signed up
        List<dynamic> result =
            await AuthController().isLogin(widget.interPhoneNo);

        if (result.length != 0) {
          SessionController.setUserType(result[0]);
          if (result[0] == Global.OWNER) {
            //when is signed up as owner
            Owner owner = result[1];
            if (owner.uid == null || owner.uid.isEmpty) {
              owner.uid = uid;
              await AuthController.changeFullOwnerInfo(owner);
            }
            // Save owner info into local storage
            SessionController.saveOwnerInfoToLocal(owner);
            Navigator.pushNamedAndRemoveUntil(
              context,
              OwnerHomeScreen.routeName,
              (Route<dynamic> route) => false,
            );
          } else if (result[0] == Global.CUSTOMER) {
            // when is signed up as customer
            Customer customer = Customer.fromJson(result[1]);
            if (customer.uid == null || customer.uid.isEmpty) {
              customer.uid = uid;
              await AuthController.changeFullCustomerInfo(customer);
            }
            SessionController.saveCustomerInfoToLocal(customer);
            Navigator.pushNamedAndRemoveUntil(
              context,
              CustomerHomeScreen.routeName,
              (Route<dynamic> route) => false,
            );
          }
        } else {
          // Go to next step to verify if you are an business owner or customer
          closeLoadingScreen();
          setState(() {
            stepperCurrentStep = 1;
            indicatorCurrentStep = 40;
          });
        }
      });
    }).catchError((e) {
      closeLoadingScreen();
      Global.showToastMessage(
          context: context,
          msg: AppLocalizations.of(context).translate('verification_failed'));
    });
  }

  registerCustomer() async {
    String result;
    customer.uid = uid;
    customer.displayName = customerDisplayName;
    customer.phoneNumber = widget.interPhoneNo;

    result = await AuthController.signUpAsCustomer(customer);
    if (result != null) {
      closeLoadingScreen();
      // Save the customer info into local storage
      customer.customerId = result;
      SessionController.saveCustomerInfoToLocal(customer);
      Navigator.pushNamedAndRemoveUntil(
        context,
        CustomerHomeScreen.routeName,
        (Route<dynamic> route) => false,
      );
    } else {
      closeLoadingScreen();
      Global.showToastMessage(
          context: context,
          msg: AppLocalizations.of(context)
              .translate('error_while_registration'));
    }
  }

  registerOwner() async {
    String result;
    owner.uid = uid;
    owner.businessName = businessName;
    owner.phoneNumber = widget.interPhoneNo;
    owner.category = category;
    result = await AuthController.signUpAsOwner(owner);
    if (result != null) {
      closeLoadingScreen();
      owner.ownerId = result;
      SessionController.saveOwnerInfoToLocal(owner);
      Navigator.pushNamedAndRemoveUntil(
        context,
        OwnerHomeScreen.routeName,
        (Route<dynamic> route) => false,
      );
    } else {
      closeLoadingScreen();
      Global.showToastMessage(
          context: context,
          msg: AppLocalizations.of(context)
              .translate('error_while_registration'));
    }
    Navigator.pushNamed(
      context,
      OwnerHomeScreen.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (stepperCurrentStep > 1) {
          if (stepperCurrentStep == 3) {
            stepperCurrentStep -= 2;
            indicatorCurrentStep -= 20;
          } else {
            stepperCurrentStep--;
            indicatorCurrentStep -= 40;
          }
          setState(() {});

          return await false;
        }
        return await true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        AppLocalizations.of(context).translate('signup'),
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            width: 75,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Hexcolor("#18d29f"),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(),
                          ),
                          Expanded(
                            child: Container(),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: steps[stepperCurrentStep],
                    ),
                  ],
                ),
                Spacer(),
                Visibility(
                  visible: stepperCurrentStep == 1 ? false : true,
                  child: MaterialButton(
                    onPressed: () {
                      switch (stepperCurrentStep) {
                        case 0:
                          phoneVerify();
                          break;
                        case 1:
                          break;
                        case 2:
                          // Step for customer display name when you are a customer
                          if (customerDisplayName != null &&
                              customerDisplayName != "") {
                            showLoadingScreen();
                            registerCustomer();
                          } else {
                            Global.showToastMessage(
                              context: context,
                              msg: AppLocalizations.of(context)
                                  .translate('please_enter_display_name'),
                            );
                          }

                          break;

                        case 3:
                          // Step for businessName and category when you are a business owner
                          if ((businessName == null || businessName == "") &&
                              (category == null)) {
                            Global.showToastMessage(
                                context: context,
                                msg: AppLocalizations.of(context)
                                    .translate('store_name'));
                          } else if ((businessName == null ||
                                  businessName == "") &&
                              category != null) {
                            Global.showToastMessage(
                                context: context,
                                msg: AppLocalizations.of(context)
                                    .translate('store_name_2'));
                          } else if (category == null &&
                              (businessName != null && businessName != "")) {
                            Global.showToastMessage(
                                context: context,
                                msg: AppLocalizations.of(context)
                                    .translate('enter_category'));
                          } else {
                            setState(() {
                              indicatorCurrentStep = 100;
                              stepperCurrentStep = 4;
                            });
                          }
                          break;

                        default:
                          showLoadingScreen();
                          registerOwner();
                      }
                    },
                    padding: EdgeInsets.only(right: 10),
                    height: 50,
                    color: stepperCurrentStep == 3
                        ? Hexcolor("#e9506a")
                        : Hexcolor("#f49ba9"),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                            stepperCurrentStep == 4
                                ? AppLocalizations.of(context)
                                    .translate('lets_go')
                                : AppLocalizations.of(context)
                                    .translate('next'),
                            style: TextStyle(color: Colors.white, fontSize: 15))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
