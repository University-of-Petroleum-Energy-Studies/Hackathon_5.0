import 'package:hackathon/styles/styles.dart';
import 'package:hackathon/widgets/DividerLine.dart';
import 'package:geolocator/geolocator.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class Help extends StatefulWidget {
  static const String id = 'help';

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  Completer<GoogleMapController> _controller = Completer();
  // controller for google map
  GoogleMapController mapController;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  double mapBottomPadding = 0;

  var geoLocator = Geolocator();
  Position currentPosition; // current position of the  user
  // method that gives us the current position  of the user
  void setPositionLocator() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;
    // Move the app along this position

    LatLng pos = LatLng(position.latitude, position.longitude);
    CameraPosition cp = new CameraPosition(target: pos, zoom: 14);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
  }

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: Container(
            width: 250,
            color: Colors.white,
            child: Drawer(
                child: ListView(
              padding: EdgeInsets.all(0),
              children: <Widget>[
                Container(
                    height: 160,
                    color: Colors.white,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        children: <Widget>[
                          Image.asset('images/user_icon.png',
                              height: 60, width: 60),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            children: <Widget>[
                              SizedBox(height: 20),
                              Text('Srajan Jaiswal',
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: 'Brand-Bold')),
                              SizedBox(height: 5),
                              Text('Edit Profile',
                                  style: TextStyle(fontSize: 15)),
                            ],
                          )
                        ],
                      ),
                    )),
                DividerLine(),
                SizedBox(height: 10),
                ListTile(
                  leading: Icon(OMIcons.cardGiftcard),
                  title: Text("Refer & Earn", style: kDrawerItemStyle),
                ),
                ListTile(
                  leading: Icon(OMIcons.history),
                  title: Text("Drive Bookings", style: kDrawerItemStyle),
                ),
                ListTile(
                  leading: Icon(OMIcons.creditCard),
                  title: Text("Payments", style: kDrawerItemStyle),
                ),
                ListTile(
                  leading: Icon(OMIcons.contactSupport),
                  title: Text("Support", style: kDrawerItemStyle),
                ),
                ListTile(
                  leading: Icon(OMIcons.info),
                  title: Text("About", style: kDrawerItemStyle),
                )
              ],
            ))),
        body: Stack(children: <Widget>[
          GoogleMap(
            padding: EdgeInsets.only(
                bottom: mapBottomPadding, top: 150, right: 10, left: 10),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kLake,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(
                  controller); // when map is created pass the instance of controller
              mapController = controller;
              setPositionLocator();
              setState(() {
                mapBottomPadding = 340;
              });
            },
          ),

          // Menu button

          Positioned(
            top: 44,
            left: 15,
            child: GestureDetector(
              onTap: () {
                scaffoldKey.currentState.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5.0,
                          spreadRadius: 0.5,
                          offset: Offset(0.7, 0.7)),
                    ]),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: Icon(
                    Icons.menu,
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
                height: 330,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 30.0,
                          spreadRadius: 1.0,
                          offset: Offset(
                            0.7,
                            0.7,
                          ))
                    ]),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 0,
                      ),
                      Text(
                        "                             Want to Ride Now ?",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.pink),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Daily        Rentals        Outstation",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5.0,
                                  spreadRadius: 5.0,
                                  offset: Offset(
                                    0.7,
                                    0.7,
                                  ))
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.search, color: Colors.purple),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Where to ?",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 22),
                      Row(
                        children: <Widget>[
                          Icon(
                            OMIcons.home,
                            color: Colors.purple,
                          ),
                          SizedBox(width: 12),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Add Home",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                SizedBox(
                                  height: 4,
                                ),
                                Text("Your residential address",
                                    style: TextStyle(color: Colors.black54)),
                              ])
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DividerLine(),
                      SizedBox(height: 14),
                      Row(
                        children: <Widget>[
                          Icon(
                            OMIcons.workOutline,
                            color: Colors.purple,
                          ),
                          SizedBox(width: 12),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Add Work",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                SizedBox(
                                  height: 4,
                                ),
                                Text("Your Office address",
                                    style: TextStyle(color: Colors.black54)),
                              ])
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DividerLine(),
                    ],
                  ),
                )),
          )
        ]));
  }
}
