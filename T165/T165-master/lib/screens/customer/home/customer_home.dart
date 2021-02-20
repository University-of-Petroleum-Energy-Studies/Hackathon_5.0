import 'package:WSHCRD/firebase_services/customer_controller.dart';
import 'package:WSHCRD/screens/customer/nearby/nearby_view.dart';
import 'package:WSHCRD/screens/customer/profile/customer_profile.dart';
import 'package:WSHCRD/screens/customer/request/new_request.dart';
import 'package:WSHCRD/screens/customer/request/request_home.dart';
import 'package:WSHCRD/utils/global.dart';
import 'package:WSHCRD/utils/session_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class CustomerHomeScreen extends StatefulWidget {
  static const routeName = 'CustomerHomeScreen';

  @override
  _CustomerHomeScreenState createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            leading: GestureDetector(
              child: Icon(
                Icons.person_outline,
                size: 30,
              ),
              onTap: () {
                Navigator.pushNamed(context, CustomerProfileView.routeName);
              },
            ),
            actions: [
              GestureDetector(
                child: Icon(
                  Icons.near_me,
                  size: 30,
                ),
                onTap: () {
                  Navigator.pushNamed(context, CustomerNearByView.routeName);
                },
              ),
              SizedBox(
                width: 10,
              )
            ],
            centerTitle: true,
            elevation: 0,
            title: Text(
              Global.appName,
              style: TextStyle(color: kTitleColor, fontWeight: FontWeight.bold),
            )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                    minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Card(
                            elevation: 3,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, NewRequestView.routeName);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 24, horizontal: 8),
                                width: EdgeInsetsGeometry.infinity.horizontal,
                                child: Text('Make a new wish'.toLowerCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    gradient: LinearGradient(colors: [
                                      Color(0xffff5f6d),
                                      Color(0xffffc371)
                                    ])),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Card(
                            elevation: 3,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, CustomerNearByView.routeName);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 24, horizontal: 8),
                                width: EdgeInsetsGeometry.infinity.horizontal,
                                child: Text(
                                    'other nearby requests'.toLowerCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    gradient: LinearGradient(colors: [
                                      Color(0xff80a1fb),
                                      Color(0xff40517e),
                                    ])),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Card(
                            elevation: 3,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RequestHomeView.routeName);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 24, horizontal: 8),
                                width: EdgeInsetsGeometry.infinity.horizontal,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('My Active wishes'.toLowerCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: StreamBuilder<QuerySnapshot>(
                                          stream: CustomerController
                                              .getAllActiveRequests(
                                                  SessionController
                                                          .getCustomerInfoFromLocal()
                                                      .customerId,
                                                  DateTime.now()
                                                      .toUtc()
                                                      .subtract(
                                                          Duration(hours: 24))),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              if (snapshot.data == null) {
                                                return Text('0',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white));
                                              } else {
                                                return Text(
                                                    '${snapshot.data.documents.length}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white));
                                              }
                                            }
                                            return Text('');
                                          }),
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    gradient: LinearGradient(colors: [
                                      Color(0xffee0979),
                                      Color(0xffff6a00),
                                    ])),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Image(
                        image: AssetImage('assets/gummy-city.png'),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
