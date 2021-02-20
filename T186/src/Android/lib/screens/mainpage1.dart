import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MainPage1 extends StatefulWidget {
  //MainPage1() : super();
  static const String id = 'mainpage1';
  final String title = 'Hackathon jeetenge';

  @override
  _MainPage1State createState() => _MainPage1State();
}

class _MainPage1State extends State<MainPage1> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging(); // instance
  List<Message> _messages;
  _getToken() {
    _firebaseMessaging.getToken().then((deviceToken) {
      print("Device Token: $deviceToken");
    });
  }

  _configureFirebaseListeners() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        _setMessage(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        _setMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        _setMessage(message);
      },
    );
  }

  _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    final String mMessage = data['message'];
    setState(() {
      Message m = Message(title, body, mMessage);
      _messages.add(m);
    });
  }

  @override
  void initState() {
    _messages = List<Message>();
    super.initState();
    _getToken();
    _configureFirebaseListeners();
  }

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
    return Theme(
      data: ThemeData(primaryIconTheme: IconThemeData(color: Colors.purple)),
      child: Scaffold(
          
          key: scaffoldKey,
         
          body: Stack(children: <Widget>[
            GoogleMap(
              padding: EdgeInsets.only(
                  bottom: mapBottomPadding, top: 50, right: 10, left: 10),
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              initialCameraPosition: _kLake,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              compassEnabled: true,
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

           
          ])),
    );
  }
}

class Message {
  String title;
  String body;
  String message;
  Message(title, body, message) {
    this.title = title;
    this.body = body;
    this.message = message;
  }
}
