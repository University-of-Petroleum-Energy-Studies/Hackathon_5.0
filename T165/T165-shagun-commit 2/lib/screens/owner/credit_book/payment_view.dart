import 'package:WSHCRD/common/algolia_text_field.dart';
import 'package:WSHCRD/firebase_services/owner_controller.dart';
import 'package:WSHCRD/models/customer.dart';
import 'package:WSHCRD/models/payment.dart';
import 'package:WSHCRD/screens/owner/credit_book/get_or_give_payment.dart';
import 'package:WSHCRD/utils/global.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentView extends StatefulWidget {
  // This is the widget for Payment View
  String customerId;
  String customerName;
  Color iconColor;
  String ledgerId;

  static const routeName = "PaymentView";

  setValues(Map<String, dynamic> values) {
    this.customerId = values['customerId'];
    this.customerName = values['customerName'];
    this.iconColor = values['iconColor'] != null ? Color(values['iconColor']) : kDefaultColorSlab;
    this.ledgerId = values['ledgerId'];
    print('ledger id ${this.ledgerId}');
  }

  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  List<Payment> paymentList = [];
  Customer customer;
  DateFormat timeFormat = DateFormat("hh:mm aa");
  DateFormat dateFormat = DateFormat("MMM dd, yyyy");
  DateTime time;
  String currentDate;
  ScrollController _scrollController = new ScrollController();
  Future contactsFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              height: 40,
              width: 40,
              child: Center(
                child: Text(widget.customerName[0], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
              ),
              decoration: BoxDecoration(
                color: widget.iconColor,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: Text(
                widget.customerName,
                overflow: TextOverflow.fade,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (customer.phoneNumber != null && customer.phoneNumber.isNotEmpty) {
                    launch('tel:${customer.phoneNumber}');
                  } else {
                    Global.showToastMessage(context: context, msg: 'Please add mobile number');
                  }
                },
                child: Icon(
                  Icons.phone,
                  color: Colors.black,
                ),
              ),
              Container(
                child: PopupMenuButton(
                  onSelected: (selected) async {
                    switch (selected) {
                      case 1:
                        showEditCustomerScreen();
                        break;
                      case 2:
                        deleteCustomerAndReturnToPreviousScreen();
                        break;
                    }
                  },
                  itemBuilder: (context) {
                    var list = List<PopupMenuEntry<Object>>();
                    list.add(
                      PopupMenuItem(
                        child: Text("Edit", style: TextStyle(fontWeight: FontWeight.w600)),
                        value: 1,
                      ),
                    );

                    list.add(
                      PopupMenuItem(
                        child: Text(
                          "Delete",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        value: 2,
                      ),
                    );
                    return list;
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FutureBuilder<Customer>(
                future: OwnerController.getCustomer(widget.customerId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    customer = snapshot.data;
                    if ((snapshot.data.phoneNumber == null || snapshot.data.phoneNumber.isEmpty)) {
                      return Container(
                        height: 85,
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 50,
                              padding: EdgeInsets.all(5),
                              child: Text(
                                  "Add ${widget.customerName}'s contact number to easily contact and remind them for dues"),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 1, color: Colors.black)),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: MaterialButton(
                                  onPressed: () {
                                    getMobileNumber(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Add mobile number",
                                        style:
                                            TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: kCreditColor,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      );
                    }
                  }

                  return Container();
                }),
            StreamBuilder<QuerySnapshot>(
                stream: OwnerController.getCustomerPayments(widget.ledgerId),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data.documents.isNotEmpty) {
                    paymentList = snapshot.data.documents.map((e) => Payment.fromJson(e.data)).toList();
                    if (paymentList == null) {
                      paymentList = [];
                    }

                    // iterate over the payments to show the balance and and all the other info

                    if (paymentList.length > 1) {
                      paymentList[paymentList.length - 1].balance =
                          paymentList[paymentList.length - 1].type == Payment.GET
                              ? paymentList[paymentList.length - 1].amount
                              : -paymentList[paymentList.length - 1].amount;
                      for (int i = paymentList.length - 2; i >= 0; i--) {
                        paymentList[i].balance = paymentList[i].type == Payment.GET
                            ? paymentList[i + 1].balance + paymentList[i].amount
                            : paymentList[i + 1].balance - paymentList[i].amount;
                      }
                    }
                    currentDate = null;
                    List<Widget> columns = [];
                    columns.add(
                      Expanded(
                        child: ListView.builder(
                            controller: _scrollController, itemCount: paymentList.length, itemBuilder: payment),
                      ),
                    );
                    columns.addAll(getReminderView());
                    return Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: columns,
                      ),
                    );
                  }
                  return Expanded(
                      child: Container(
                    child: Center(child: Text('No Transactions found for ${widget.customerName}')),
                  ));
                }),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: kBorderColor, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: MaterialButton(
                                height: 65,
                                onPressed: () {
                                  goToGiveOrGetPayment(Payment.GET);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.arrow_downward,
                                      color: kCreditColor,
                                    ),
                                    Text(
                                      "Payment",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: kCreditColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          VerticalDivider(
                            width: 1,
                            color: kBorderColor,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                margin: EdgeInsets.only(left: 3),
                                alignment: Alignment.center,
                                child: MaterialButton(
                                  height: 65,
                                  onPressed: () {
                                    goToGiveOrGetPayment(Payment.GIVE);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Credit",
                                        style: TextStyle(
                                            fontSize: 15, color: Hexcolor("#e9194b"), fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.center,
                                      ),
                                      Icon(
                                        Icons.arrow_upward,
                                        color: Hexcolor("#e9194b"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  /*
  calculate time differnece so that it can be shown as Today,10 June 2020 etc
   */
  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
  }

  Widget payment(BuildContext context, int index) {
    String balanceText =
        '${NumberFormat.currency(symbol: '\$', decimalDigits: 2).format(paymentList[index].balance.abs())} ' +
            (paymentList[index].balance > 0 ? "Advance" : "Due");
    DateTime dateTime = (DateTime.fromMillisecondsSinceEpoch(paymentList[index].dateTimeInEpoc, isUtc: true).toLocal());
    String date = calculateDifference(dateTime) == 0 ? 'Today' : dateFormat.format(dateTime);
    List<Widget> widgets = [];
    if (date != currentDate) {
      currentDate = date;
      widgets.add(
        SizedBox(
          height: 10,
        ),
      );
      widgets.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Center(
                child: Text(
                  currentDate,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ],
        ),
      );
      widgets.add(
        SizedBox(
          height: 10,
        ),
      );
    }
    widgets.add(
      Padding(
        padding: EdgeInsets.only(bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment:
                  paymentList[index].type == Payment.GET ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            NumberFormat.currency(symbol: '\$', decimalDigits: 2).format(paymentList[index].amount),
                            style: TextStyle(
                              color: paymentList[index].type == Payment.GET ? kCreditColor : kDebitColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            timeFormat.format(
                                DateTime.fromMillisecondsSinceEpoch(paymentList[index].dateTimeInEpoc, isUtc: true)
                                    .toLocal()),
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                      paymentList[index].remarks != null && paymentList[index].remarks.isNotEmpty
                          ? ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width / 2,
                              ),
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      paymentList[index].remarks,
                                      style: TextStyle(color: Colors.black, fontSize: 12),
                                      overflow: TextOverflow.clip,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: kBorderColorLight), borderRadius: BorderRadius.circular(5)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment:
                  paymentList[index].type == Payment.GET ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width * 8 / 15,
                    padding: EdgeInsets.only(top: 5),
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Align(
                      alignment: paymentList[index].type == Payment.GET ? Alignment.centerLeft : Alignment.centerRight,
                      child: Text(
                        balanceText,
                        style: TextStyle(fontSize: 12, color: Hexcolor("#707070"), fontWeight: FontWeight.w600),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
    return Column(
      children: widgets,
    );
  }

  List<Widget> getReminderView() {
    return [
      SizedBox(
        height: 10,
      ),
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            paymentList.length != 0 && paymentList[paymentList.length - 1].balance != null
                ? Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 50,
                    child: paymentList[0].balance < 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Balance Due",
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                NumberFormat.currency(symbol: '\$').format(paymentList[0].balance.abs()),
                                style: TextStyle(color: kDebitColor, fontSize: 17, fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Balance Advance",
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                NumberFormat.currency(symbol: '\$').format(paymentList[0].balance.abs()),
                                style: TextStyle(color: kCreditColor, fontSize: 17, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                    decoration: BoxDecoration(
                      color: Color(0xffEDF1F2),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Balance Due",
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          NumberFormat.currency(symbol: '\$').format(0),
                          style: TextStyle(color: kDebitColor, fontSize: 17, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffEDF1F2),
                      border: Border(bottom: BorderSide(width: 1, color: kBorderColorLight)),
                    ),
                  ),
            Visibility(
              visible: paymentList.isNotEmpty && paymentList[0].balance != null && paymentList[0].balance < 0,
              child: Container(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 1 / 5),
                  child: MaterialButton(
                    onPressed: () {
                      if (customer.phoneNumber != null && customer.phoneNumber.isNotEmpty) {
                        launch('tel:${customer.phoneNumber}');
                      } else {
                        Global.showToastMessage(context: context, msg: 'Please add mobile number');
                      }
                    },
                    color: kCreditColor,
                    height: 35,
                    child: Text(
                      "Request Payment",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(width: 1, color: kBorderColorLight)),
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          border: Border.all(color: kBorderColorLight),
          borderRadius: BorderRadius.all(Radius.circular(5.0) //                 <--- border radius here
              ),
        ),
      ),
    ];
  }

  void getMobileNumber(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add Mobile Number"),
            content: InternationalPhoneInput(
              decoration: InputDecoration.collapsed(
                  hintText: 'Enter your number', hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
              initialPhoneNumber: "",
              onPhoneNumberChange: (_number, _internationalizedPhoneNumber, _isoCode) {
                customer.phoneNumber = _internationalizedPhoneNumber;
              },
              initialSelection: "in",
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: new Text("OK"),
                onPressed: () async {
                  if (customer.phoneNumber == null || customer.phoneNumber.isEmpty) {
                    Global.showToastMessage(context: context, msg: "Invalid Number");
                  } else {
                    showLoadingScreen();
                    try {
                      await OwnerController.updateCustomerPhoneNumber(customer);
                      Global.showToastMessage(context: context, msg: "Update Successful");
                    } catch (e) {
                      Global.showToastMessage(context: context, msg: "Update failed");
                    }

                    setState(() {});
                    closeLoadingScreen();
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        });
  }
  /*
  populate the fields and go to payment screen
   */

  void goToGiveOrGetPayment(String type) {
    Navigator.pushNamed(context, GetOrGivePayment.routeName, arguments: {
      'color': widget.iconColor.value,
      'customerId': widget.customerId,
      'customerName': widget.customerName,
      'ledgerId': widget.ledgerId,
      'iconColor': widget.iconColor,
      'currentBalance': (paymentList == null || paymentList.isEmpty) ? 0.0 : paymentList[0].balance,
      'type': type,
    });
  }

  void showEditCustomerScreen() {
    TextEditingController nameController = new TextEditingController();
    nameController.text = widget.customerName;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Edit Customer"),
            actions: <Widget>[
              FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: new Text("Save"),
                onPressed: () async {
                  updateCustomer(nameController);
                },
              ),
            ],
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AlgoliaTextField(
                    label: 'Name',
                    controller: nameController,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> deleteCustomerAndReturnToPreviousScreen() async {
    showLoadingScreen();
    try {
      await OwnerController.deleteCustomer(customer.customerId, widget.ledgerId);
    } catch (e) {
      BotToast.showText(text: 'Error deleting customer');
    }
    closeLoadingScreen();
    Navigator.pop(context);
  }

  Future<void> updateCustomer(TextEditingController nameController) async {
    if (nameController.text.isEmpty) {
      Global.showToastMessage(context: context, msg: "Name cannot be empty!!");
    } else {
      if (widget.customerName == nameController.text) {
        Global.showToastMessage(context: context, msg: "There is no difference in the name");
      } else {
        showLoadingScreen();
        try {
          customer.displayName = nameController.text;
          await OwnerController.updateCustomerName(customer);
          widget.customerName = nameController.text;
          Global.showToastMessage(context: context, msg: "Update Successful");
        } catch (e) {
          Global.showToastMessage(context: context, msg: "Update failed");
        }
        setState(() {});
        closeLoadingScreen();
        Navigator.pop(context);
      }
    }
  }
}
