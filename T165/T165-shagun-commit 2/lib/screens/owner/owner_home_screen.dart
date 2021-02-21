import 'package:WSHCRD/common/locatization.dart';
import 'package:WSHCRD/firebase_services/customer_controller.dart';
import 'package:WSHCRD/firebase_services/owner_controller.dart';
import 'package:WSHCRD/models/ledger.dart';
import 'package:WSHCRD/models/owner.dart';
import 'package:WSHCRD/models/request.dart';
import 'package:WSHCRD/screens/customer/request/request_home.dart';
import 'package:WSHCRD/screens/owner/credit_book/credit_book.dart';
import 'package:WSHCRD/screens/owner/my_bids/my_bids.dart';
import 'package:WSHCRD/screens/owner/nearby/nearby_view.dart';
import 'package:WSHCRD/screens/owner/orders_view.dart';
import 'package:WSHCRD/screens/owner/profile/owner_profile.dart';
import 'package:WSHCRD/utils/global.dart';
import 'package:WSHCRD/utils/session_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as flutterLoc;
import 'package:location/location.dart';

class OwnerHomeScreen extends StatefulWidget {
  static const routeName = 'OwnerHomeScreen';

  @override
  _OwnerHomeScreenState createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen>
    with WidgetsBindingObserver {
  bool didPausedBefore = false;
  flutterLoc.LocationData ownerLocation;
  Owner owner;
  @override
  void initState() {
    super.initState();
    owner = SessionController.getOwnerInfoFromLocal();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<bool> didPopRoute() {
    return super.didPopRoute();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (didPausedBefore) {
        didPausedBefore = false;
        setState(() {});
      }
    } else if (state == AppLifecycleState.paused) {
      didPausedBefore = true;
    }
  }

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
                Navigator.pushNamed(context, OwnerProfile.routeName);
              },
            ),
            actions: [
              GestureDetector(
                child: Icon(
                  Icons.near_me,
                  size: 30,
                ),
                onTap: () async {
                  Navigator.pushNamed(context, OwnerNearByView.routeName);
                },
              ),
              SizedBox(
                width: 10,
              )
            ],
            centerTitle: true,
            elevation: 0,
            title: Text(
              SessionController.getOwnerInfoFromLocal().businessName,
              style: TextStyle(color: kTitleColor, fontWeight: FontWeight.bold),
            )),
        body: SingleChildScrollView(
          child: StreamBuilder<Owner>(
              stream: SessionController.getOwnerStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  owner = snapshot.data;
                  ownerLocation = flutterLoc.LocationData.fromMap({
                    'latitude': snapshot.data.location.latitude,
                    'longitude': snapshot.data.location.longitude
                  });
                  return Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Card(
                                elevation: 10,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, OwnerNearByView.routeName);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 24, horizontal: 8),
                                    width:
                                        EdgeInsetsGeometry.infinity.horizontal,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                                AppLocalizations.of(context)
                                                    .translate(
                                                        'active_requests'),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 24),
                                              child: StreamBuilder<int>(
                                                  stream: SessionController
                                                      .getRadiusStream(),
                                                  builder: (context,
                                                      radiusSnapShot) {
                                                    if (radiusSnapShot
                                                        .hasData) {
                                                      return Text(
                                                          kRadiusListText[
                                                              radiusSnapShot
                                                                  .data],
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .subtitle1
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black));
                                                    } else {
                                                      return Text('-');
                                                    }
                                                  }),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              120))),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        StreamBuilder<int>(
                                          stream: SessionController
                                              .getRadiusStream(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<int>
                                                  radiusSnapshot) {
                                            if (radiusSnapshot.hasData) {
                                              return StreamBuilder<
                                                      List<DocumentSnapshot>>(
                                                  stream: OwnerController
                                                      .getAllActiveNearByRequestsForRadius(
                                                          kRadiusList[
                                                              radiusSnapshot
                                                                  .data],
                                                          ownerLocation),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData &&
                                                        snapshot.data.length >
                                                            0) {
                                                      DateTime yesterdayTime =
                                                          getYesterdayTime();
                                                      List<Request> requests =
                                                          snapshot.data
                                                              .map((e) => Request
                                                                  .fromJson(
                                                                      e.data))
                                                              .toList()
                                                              .where((element) {
                                                        return ((element.requestVisibility ==
                                                                    Request
                                                                        .REQ_VISIBILITY_BOTH ||
                                                                element.requestVisibility ==
                                                                    Request
                                                                        .REQ_VISIBILITY_STORES_ONLY) &&
                                                            (element.category ==
                                                                owner
                                                                    .category) &&
                                                            element.creationDateInEpoc >
                                                                yesterdayTime
                                                                    .millisecondsSinceEpoch);
                                                      }).toList();
                                                      if (snapshot.data ==
                                                          null) {
                                                        return Text('0',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline5
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white));
                                                      } else {
                                                        return Text(
                                                            '${requests.length}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline5
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white));
                                                      }
                                                    }
                                                    return Text('0',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white));
                                                  });
                                            } else {
                                              return Text('0',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white));
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        gradient: LinearGradient(colors: [
                                          Color(0xffff5f6d),
                                          Color(0xffffc371),
                                        ])),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Card(
                                elevation: 3,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, CreditBook.routeName);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 24, horizontal: 8),
                                    width:
                                        EdgeInsetsGeometry.infinity.horizontal,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                            AppLocalizations.of(context)
                                                .translate('credit_book'),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        StreamBuilder<QuerySnapshot>(
                                            stream: OwnerController
                                                .getTotalBalance(SessionController
                                                        .getOwnerInfoFromLocal()
                                                    .ownerId),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                if (snapshot.data == null) {
                                                  return Text('0',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .white));
                                                } else {
                                                  String balanceText = '0';
                                                  double totalBalance = 0;
                                                  snapshot.data.documents
                                                      .forEach((element) {
                                                    totalBalance +=
                                                        element.data['balance'];
                                                  });
                                                  balanceText =
                                                      NumberFormat.currency(
                                                                  symbol: '\₹')
                                                              .format(
                                                                  totalBalance
                                                                      .abs()) +
                                                          " ";
                                                  if (totalBalance > 0) {
                                                    balanceText +=
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                'advance');
                                                  } else {
                                                    balanceText +=
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate('due');
                                                  }

                                                  return Text(balanceText,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .white));
                                                }
                                              }
                                              return Text('');
                                            })
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        gradient: LinearGradient(colors: [
                                          Color(0xffee9ca7),
                                          Color(0xffffdde1),
                                        ])),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }),
        ),
      ),
    );
  }
}
