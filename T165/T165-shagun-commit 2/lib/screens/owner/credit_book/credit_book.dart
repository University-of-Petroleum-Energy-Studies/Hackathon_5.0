import 'dart:async';

import 'package:WSHCRD/firebase_services/owner_controller.dart';
import 'package:WSHCRD/models/customer.dart';
import 'package:WSHCRD/models/ledger.dart';
import 'package:WSHCRD/models/owner.dart';
import 'package:WSHCRD/models/payment.dart';
import 'package:WSHCRD/screens/owner/credit_book/payment_view.dart';
import 'package:WSHCRD/utils/global.dart';
import 'package:WSHCRD/utils/session_controller.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import 'add_customer.dart';

class CreditBook extends StatefulWidget {
  static const routeName = "CreditBook";

  @override
  _CreditBookState createState() => _CreditBookState();
}

class _CreditBookState extends State<CreditBook> {
  List<Customer> mainCustomerList = [];
  List<Customer> tempCustomerList = [];
  String businessName;
  StreamController<List<Customer>> customerStreamController;
  TextEditingController searchTextController = new TextEditingController();
  bool isCustomerHeaderShown = false;
  bool isContactHeaderShown = false;
  FocusNode searchFocus;
  Owner owner;
  Map<String, Ledger> customerToLedgerMap = {};
  Map<String, int> customersIndexMap = {};
  Stream<QuerySnapshot> mainCustomerStream;
  Stream customerStream;
  StreamSubscription mainCustomerStreamSubscription;

  @override
  void initState() {
    customerStreamController = StreamController<List<Customer>>();
    customerStream = customerStreamController.stream.asBroadcastStream();
    businessName = SessionController.getBusinessName();
    owner = SessionController.getOwnerInfoFromLocal();
    requestPermission(Permission.contacts);
    mainCustomerStream = OwnerController.getCustomersStream(owner.ownerId);
    mainCustomerStreamSubscription = mainCustomerStream.listen(getStreamListener());
    super.initState();
  }

  getStreamListener() {
    return (even) {
      QuerySnapshot event = even;
      mainCustomerList = event.documents.map((e) => Customer.fromJson(e.data)).toList();

      /*
      Sort the customers depending upon their last modified date and if not present consider their
      creation date so that the last modified customer is shown on top
       */
      mainCustomerList.sort((a, b) {
        if (!customerToLedgerMap.containsKey(b.customerId)) {
          return 1;
        } else if (!customerToLedgerMap.containsKey(a.customerId)) {
          return -1;
        } else if (customerToLedgerMap[a.customerId].lastUpdateDateInEpoc == null &&
            customerToLedgerMap[b.customerId].lastUpdateDateInEpoc == null) {
          return customerToLedgerMap[b.customerId].creationDateInEpoc -
              customerToLedgerMap[a.customerId].creationDateInEpoc;
        } else if (customerToLedgerMap[a.customerId].lastUpdateDateInEpoc == null) {
          return customerToLedgerMap[b.customerId].lastUpdateDateInEpoc -
              customerToLedgerMap[a.customerId].creationDateInEpoc;
        } else if (customerToLedgerMap[b.customerId].lastUpdateDateInEpoc == null) {
          return customerToLedgerMap[b.customerId].creationDateInEpoc -
              customerToLedgerMap[a.customerId].lastUpdateDateInEpoc;
        } else {
          return customersIndexMap[a.customerId] - customersIndexMap[b.customerId];
        }
      });
      customerStreamController.add(mainCustomerList);
    };
  }

  @override
  void dispose() {
    customerStreamController.close();
    mainCustomerStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            'My Creditbook'.toUpperCase(),
            style: TextStyle(color: kTitleColor, fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Hexcolor("#18d29f"),
          onPressed: () {
            Navigator.pushNamed(context, AddCustomer.routeName);
          },
          icon: Icon(Icons.add),
          label: Text("Add Customer".toUpperCase()),
        ),
        body: Container(
          color: Colors.white,
          child: Container(
            color: Colors.white,
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: <Widget>[
                Container(
                  child: TextFormField(
                    focusNode: searchFocus,
                    controller: searchTextController,
                    onChanged: (value) {
                      showSearchedContactsToTheList(value);
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        size: 25,
                        color: Colors.black,
                      ),
                      hintText: "search or add",
                      hintStyle:
                          TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w700),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: OwnerController.getAllLedgersForOwner(owner.ownerId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.documents != null && snapshot.data.documents.isNotEmpty) {
                          customerToLedgerMap = {};
                          customersIndexMap = {};
                          int count = 0;

                          //Getting all the ledgers so that last payment or modified dates can be found.
                          snapshot.data.documents.forEach((element) {
                            Ledger ledger = Ledger.fromJson(element.data);
                            customerToLedgerMap[ledger.customerId] = ledger;
                            customersIndexMap[ledger.customerId] = count++;
                          });

                          if (mainCustomerStreamSubscription != null) {
                            mainCustomerStreamSubscription.cancel();
                          }
                          mainCustomerStream = OwnerController.getCustomersStream(owner.ownerId);
                          mainCustomerStreamSubscription = mainCustomerStream.listen(getStreamListener());
                          return Expanded(
                            child: StreamBuilder<List<Customer>>(
                              stream: customerStream,
                              builder: (context, snapshot) {
                                isCustomerHeaderShown = false;
                                isContactHeaderShown = false;
                                if (snapshot.hasData) {
                                  isCustomerHeaderShown = false;
                                  isContactHeaderShown = false;
                                  if (snapshot.data.isNotEmpty) {
                                    List<Customer> customerList = snapshot.data;
                                    return ListView.builder(
                                        itemCount: customerList.length,
                                        itemBuilder: (context, index) => processListItem(context, index, customerList));
                                  } else if (searchTextController.text == null || searchTextController.text.isEmpty) {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Image(
                                          image: AssetImage('assets/fogg-no-messages.png'),
                                        ),
                                        Text(
                                          'click on "Add cutomer" to get started',
                                          style: TextStyle(color: Color(0xff1d4ff2), fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    );
                                  }
                                }
                                return Container();
                              },
                            ),
                          );
                        } else {
                          return Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                  image: AssetImage('assets/fogg-no-messages.png'),
                                ),
                                Text(
                                  'click on "Add cutomer" to get started',
                                  style: TextStyle(color: Color(0xff1d4ff2), fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          );
                        }
                      } else {
                        return Container();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget processListItem(BuildContext context, int index, List<Customer> customerList) {
    if (customerList[index].uid == 'CONTACT') {
      // identify if this is a contact or existing customer
      // show contact cards
      Widget widget = Column(
        children: <Widget>[
          !isContactHeaderShown
              ? Container(
                  width: EdgeInsetsGeometry.infinity.along(Axis.horizontal),
                  padding: EdgeInsets.all(8),
                  color: Hexcolor("#f5f5f5"),
                  child: Text(
                    "Phonebook Contacts",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              : Container(),
          InkWell(
            onTap: () {
              setState(() {
                FocusScope.of(context).unfocus();
                searchTextController.clear();
              });

              addNewCustomer(context, customerList[index].displayName, customerList[index].phoneNumber,
                  popAndPush: false);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 40,
                      width: 40,
                      child: Center(
                        child: Text(customerList[index].displayName[0], style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      decoration: BoxDecoration(
                        color: kColorSlabs[index % kColorSlabs.length],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          customerList[index].displayName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 8),
            child: Divider(
              color: Colors.black,
              thickness: 0.5,
            ),
          ),
        ],
      );
      isContactHeaderShown = true;
      return widget;
    } else {
      // show customer cards
      Widget widget = Column(
        children: <Widget>[
          !isCustomerHeaderShown
              ? Container(
                  width: EdgeInsetsGeometry.infinity.along(Axis.horizontal),
                  padding: EdgeInsets.all(8),
                  color: Hexcolor("#f5f5f5"),
                  child: Text(
                    "Customers",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              : Container(),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, PaymentView.routeName, arguments: {
                'iconColor': kColorSlabs[index % kColorSlabs.length].value,
                'customerId': customerList[index].customerId,
                'customerName': customerList[index].displayName,
                'ledgerId': customerToLedgerMap[customerList[index].customerId]?.ledgerId
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 40,
                      width: 40,
                      child: Center(
                        child: Text(customerList[index].displayName[0], style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      decoration: BoxDecoration(
                        color: kColorSlabs[index % kColorSlabs.length],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          customerList[index].displayName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        getTransactionView(customerList[index]),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: getBalanceView(customerToLedgerMap[customerList[index].customerId] != null
                        ? customerToLedgerMap[customerList[index].customerId].balance
                        : 0),
                  ),
                  SizedBox(
                    width: 8,
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 8),
            child: Divider(
              color: Colors.black,
              thickness: 0.5,
            ),
          ),
        ],
      );
      isCustomerHeaderShown = true;
      return widget;
    }
  }

  /*
  The view which shows what was the last activity/transaction for this particular customer
   */
  getTransactionView(Customer customer) {
    Ledger ledger = customerToLedgerMap[customer.customerId];
    if (ledger != null && ledger.hasPayments != null && ledger.hasPayments && ledger.lastUpdateDateInEpoc != null) {
      String message = ledger.lastPayType == Payment.GET ? 'Payment added ' : 'Gave credit';
      String formattedAmount =
          NumberFormat.currency(symbol: "\$").format(ledger.lastPayAmount != null ? ledger.lastPayAmount.abs() : 0);
      return Text(
        '$message $formattedAmount',
        style: TextStyle(fontSize: 12),
      );
    } else {
      return Row(
        children: <Widget>[
          Icon(
            Icons.person,
            size: 12,
          ),
          SizedBox(
            width: 3,
          ),
          Expanded(
            child: Text(
              'Added On ' +
                  DateFormat('dd MMM, yyyy').format(
                      DateTime.fromMillisecondsSinceEpoch(customer.creationDateInEpoc ?? 0, isUtc: true).toLocal()),
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      );
    }
  }

  /*
    show current balance of the customer debit / credit
   */
  getBalanceView(double balance) {
    if (balance != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            NumberFormat.currency(symbol: '\$').format(balance.abs()),
            style: TextStyle(color: balance < 0 ? kDebitColor : kCreditColor),
          ),
          Text(
            balance < 0 ? "Due" : "Advance",
            style: TextStyle(fontSize: 10),
          ),
        ],
      );
    } else {
      Container();
    }
  }

  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();
    setState(() {
      print(status);
    });
  }

  void showSearchedContactsToTheList(String value) {
    setState(() async {
      tempCustomerList = List.from(mainCustomerList);
      tempCustomerList.retainWhere((element) => element.displayName.toUpperCase().contains(value.toUpperCase()));
      if (value.isNotEmpty) {
        var contacts = await ContactsService.getContacts(withThumbnails: false, query: value);
        contacts.forEach((element) {
          if (element.givenName != null && element.phones.isNotEmpty) {
            String phoneNumber = element.phones.toList()[0].value;
            // CONTACT is added to identify contacts from actual customers
            tempCustomerList.add(Customer(uid: "CONTACT", displayName: element.givenName, phoneNumber: phoneNumber));
          }
        });
      }
      customerStreamController.add(tempCustomerList);
    });
  }
}
