import 'package:WSHCRD/common/circle.dart';
import 'package:WSHCRD/common/request_card.dart';
import 'package:WSHCRD/common/selected_circle.dart';
import 'package:WSHCRD/firebase_services/customer_controller.dart';
import 'package:WSHCRD/models/request.dart';
import 'package:WSHCRD/screens/customer/request/new_request.dart';
import 'package:WSHCRD/screens/owner/categories.dart';
import 'package:WSHCRD/utils/global.dart';
import 'package:WSHCRD/utils/session_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as flutterLoc;

class CustomerNearByView extends StatefulWidget {
  static const routeName = 'CustomerNearByView';

  @override
  _CustomerNearByViewState createState() => _CustomerNearByViewState();
}

class _CustomerNearByViewState extends State<CustomerNearByView> {
  int selectedRadius = 0;
  String category;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Near By'.toUpperCase(),
            style: TextStyle(color: kTitleColor, fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kColorSlabs[4],
          onPressed: () {
            Navigator.pushNamed(context, NewRequestView.routeName);
          },
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<flutterLoc.LocationData>(
              future: Global.getLocation(),
              builder: (context, currentLocationSnapshot) {
                if (currentLocationSnapshot.hasData) {
                  if (currentLocationSnapshot.data != null) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width *
                                          2.5 /
                                          15,
                                ),
                                child: Divider(
                                  color: Colors.black,
                                  height: 1,
                                  thickness: 1,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            1 /
                                            20),
                                height: 50,
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Expanded(
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        child: selectedCircle,
                                        onTap: () {
                                          setState(() {
                                            selectedRadius = 0;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        child: selectedRadius > 0
                                            ? selectedCircle
                                            : circle,
                                        onTap: () {
                                          setState(() {
                                            selectedRadius = 1;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        child: selectedRadius > 1
                                            ? selectedCircle
                                            : circle,
                                        onTap: () {
                                          setState(() {
                                            selectedRadius = 2;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        child: selectedRadius > 2
                                            ? selectedCircle
                                            : circle,
                                        onTap: () {
                                          setState(() {
                                            selectedRadius = 3;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            kRadiusListText[selectedRadius],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: GestureDetector(
                            onTap: () => navigateAndGetCategory(),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  category ?? "All Category",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.expand_more,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: StreamBuilder<List<DocumentSnapshot>>(
                              stream: CustomerController
                                  .getAllActiveNearByRequestsForRadius(
                                      DateTime.now()
                                          .toUtc()
                                          .subtract(Duration(hours: 24)),
                                      kRadiusList[selectedRadius],
                                      currentLocationSnapshot.data),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  DateTime yesterdayTime = getYesterdayTime();
                                  List<Request> requests = snapshot.data
                                      .map((e) => Request.fromJson(e.data))
                                      .toList()
                                      .where(
                                    (element) {
                                      return getRelevantRequest(
                                          yesterdayTime, element);
                                    },
                                  ).toList();

                                  if (requests.isNotEmpty) {
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: requests.length,
                                        itemBuilder:
                                            (BuildContext ctxt, int index) {
                                          return Container(
                                            margin: EdgeInsets.all(10),
                                            child: RequestCard(
                                              requests[index],
                                              index,
                                              type: RequestCard.NEARBY,
                                              currentLocation:
                                                  currentLocationSnapshot.data,
                                            ),
                                            decoration: BoxDecoration(
                                                shape: BoxShape
                                                    .rectangle, // BoxShape.circle or BoxShape.retangle
                                                //color: const Color(0xFF66BB6A),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 8.0,
                                                  ),
                                                ]),
                                          );
                                        });
                                  } else {
                                    return Container(
                                      child: Center(
                                          child: Text(
                                              'No Request found for the given radius')),
                                    );
                                  }
                                }
                                return Container();
                              }),
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      child: Center(
                          child: Text(
                              'Please enable your location and provide the permision for same')),
                    );
                  }
                } else {
                  return Container(
                    child: Center(child: Text('Getting your location')),
                  );
                }
              }),
        ),
      ),
    );
  }

  navigateAndGetCategory() async {
    // Navigate and get the selected category
    var _category = await Navigator.pushNamed(
      context,
      Categories.routeName,
    );
    setState(() {
      category = _category;
    });
  }

  /*
    This makes sure that the customer sees only the relevant requests as per the
    filters and the request's visibility criteria.
    Filters:
      1. Discard own requests
      2. Request visibility should be relevant
      3. Discard un matching category
   */
  getRelevantRequest(DateTime yesterdayTime, Request element) {
    return element.ownerId !=
            SessionController.getCustomerInfoFromLocal().customerId &&
        element.creationDateInEpoc > yesterdayTime.millisecondsSinceEpoch &&
        (category == null || element.category == category) &&
        (element.requestVisibility == Request.REQ_VISIBILITY_BOTH ||
            element.requestVisibility == Request.REQ_VISIBILITY_NEARBY_ONLY);
  }
}
