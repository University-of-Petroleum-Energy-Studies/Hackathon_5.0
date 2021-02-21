import 'package:WSHCRD/firebase_services/auth_controller.dart';
import 'package:WSHCRD/models/customer.dart';
import 'package:WSHCRD/screens/start.dart';
import 'package:WSHCRD/utils/global.dart';
import 'package:WSHCRD/utils/session_controller.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class CustomerEditProfile extends StatefulWidget {
  static const routeName = 'CustomerEditProfile';

  @override
  _CustomerEditProfileState createState() => _CustomerEditProfileState();
}

class _CustomerEditProfileState extends State<CustomerEditProfile> {
  Customer customer;
  TextEditingController phoneNumberController = new TextEditingController();

  @override
  void initState() {
    customer = SessionController.getCustomerInfoFromLocal();
    phoneNumberController.text = customer.phoneNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return updateProfileAndSendDataBackToCallingWidget();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'My Details',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10, top: 16),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    child: Icon(Icons.perm_identity, size: 35),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "Display Name",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextFormField(
                          initialValue: customer.displayName,
                          onChanged: (value) {
                            setState(() {
                              customer.displayName = value;
                            });
                          },
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "This name will be visible to other users",
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
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
                          onChanged: (value) {
                            setState(() {
                              customer.phoneNumber = value;
                            });
                          },
                          controller: phoneNumberController,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool hasDataChanged() {
    return SessionController.getDisplayName() != customer.displayName ||
        SessionController.getPhoneNumber() != customer.phoneNumber;
  }

  /*
    Update the profile if changes are detected and then send the data back to calling widget
   */
  Future<bool> updateProfileAndSendDataBackToCallingWidget() async {
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
                      Customer localCustomer = SessionController.getCustomerInfoFromLocal();
                      phoneNumberController.text = localCustomer.phoneNumber;
                      customer.phoneNumber = localCustomer.phoneNumber;
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: new Text("YES"),
                    onPressed: () async {
                      customer.uid = null;
                      await updateUser();
                      logOutAndReturnToLoginScreen(context);
                    },
                  ),
                ],
              );
            });
      } else {
        await updateUser();
        Navigator.pop(context, customer);
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

  bool hasPhoneNumberChanged() {
    return SessionController.getCustomerInfoFromLocal().phoneNumber != customer.phoneNumber;
  }

  updateUser() async {
    showLoadingScreen();
    await saveChanges();
    closeLoadingScreen();
    BotToast.showText(text: "Profile Updated Successfully");
  }

  /*
  Save changes to firebase
   */
  saveChanges() async {
    await AuthController.changeCustomerInfo(customer);
  }
}
