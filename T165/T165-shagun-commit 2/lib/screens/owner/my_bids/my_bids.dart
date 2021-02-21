import 'package:WSHCRD/utils/global.dart';
import 'package:flutter/material.dart';

class MyBidsView extends StatefulWidget {
  static const routeName = 'MyBids';
  @override
  _MyBidsViewState createState() => _MyBidsViewState();
}

class _MyBidsViewState extends State<MyBidsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            'MY BIDS'.toUpperCase(),
            style: TextStyle(color: kTitleColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          child: Center(
            child: Text(
              "No bids to show",
            ),
          ),
        ),
      ),
    );
  }
}
