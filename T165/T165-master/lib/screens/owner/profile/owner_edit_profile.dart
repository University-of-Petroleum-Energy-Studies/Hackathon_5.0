import 'package:WSHCRD/common/locatization.dart';
import 'package:WSHCRD/firebase_services/auth_controller.dart';
import 'package:WSHCRD/models/owner.dart';
import 'package:WSHCRD/screens/owner/categories.dart';
import 'package:WSHCRD/screens/start.dart';
import 'package:WSHCRD/utils/global.dart';
import 'package:WSHCRD/utils/session_controller.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class OwnerEditProfile extends StatefulWidget {
  static const routeName = 'OwnerEditProfile';

  @override
  _OwnerEditProfileState createState() => _OwnerEditProfileState();
}

class _OwnerEditProfileState extends State<OwnerEditProfile> {
  Owner owner;
  TextEditingController phoneNumberController = new TextEditingController();

  navigateAndGetCategory() async {
    // Change Selected Category
    var _category = await Navigator.pushNamed(
      context,
      Categories.routeName,
    );
    setState(() {
      owner.category = _category;
    });
  }

  @override
  void initState() {
    owner = SessionController.getOwnerInfoFromLocal();
    phoneNumberController.text = owner.phoneNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return validateAndSaveChangesAndGoBackToCallingWidget();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          title: Text(
            AppLocalizations.of(context).translate('my_details'),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.only(right: 10),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Container(
                height: 100,
                child: Row(
                  children: <Widget>[
                    Container(width: 60, child: Image.asset("assets/icons/business.png")),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context).translate('business_name_header'),
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          TextFormField(
                            onChanged: (value) {
                              setState(() {
                                owner.businessName = value;
                              });
                            },
                            initialValue: owner.businessName,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              "This name will be visible to your customers",
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Divider(color: Colors.black, height: 1),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 60,
                      child: Icon(Icons.smartphone, size: 35),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "Mobile Number",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          TextFormField(
                            controller: phoneNumberController,
                            onChanged: (value) {
                              setState(() {
                                owner.phoneNumber = value;
                              });
                            },
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 60,
                      child: Image.asset('assets/icons/building.png'),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Business Category", style: TextStyle(fontWeight: FontWeight.w600)),
                          GestureDetector(
                            onTap: () => navigateAndGetCategory(),
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(owner.category, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                                  Icon(Icons.expand_more),
                                ],
                              ),
                            ),
                          ),
                          Divider(color: Colors.black, height: 1),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  saveChanges() async {
    await AuthController.changeOwnerInfo(owner);
  }

  bool hasDataChanged() {
    Owner localOwner = SessionController.getOwnerInfoFromLocal();

    return localOwner.businessName != owner.businessName ||
        localOwner.category != owner.category ||
        localOwner.phoneNumber != owner.phoneNumber;
  }

  Future<bool> validateAndSaveChangesAndGoBackToCallingWidget() async {
    if (hasDataChanged()) {
      if (hasPhoneNumberChanged()) {
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Do you want to change your mobile number?"),
                content: Text(
                    'You will be logged out and will have to login again with updated number, do you want to proceed?'),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  FlatButton(
                    child: new Text("NO"),
                    onPressed: () {
                      Owner localOwner = SessionController.getOwnerInfoFromLocal();
                      phoneNumberController.text = localOwner.phoneNumber;
                      owner.phoneNumber = localOwner.phoneNumber;
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: new Text("YES"),
                    onPressed: () async {
                      owner.uid = null;
                      await updateUser();
                      logOutAndReturnToLoginScreen(context);
                    },
                  ),
                ],
              );
            });
      } else {
        await updateUser();
        Navigator.pop(context, owner);
      }
      return false;
    } else {
      return true;
    }
  }

  Future<void> logOutAndReturnToLoginScreen(BuildContext context) async {
    await AuthController.logoutUser();
    await SessionController.clearSession();
    BotToast.showText(text: "User logged out successfully");
    Navigator.pushReplacementNamed(context, Start.routeName);
  }

  updateUser() async {
    showLoadingScreen();
    await saveChanges();
    closeLoadingScreen();
    BotToast.showText(text: AppLocalizations.of(context).translate('profile_updated_successfully'));
  }

  bool hasPhoneNumberChanged() {
    Owner localOwner = SessionController.getOwnerInfoFromLocal();
    return localOwner.phoneNumber != owner.phoneNumber;
  }
}
