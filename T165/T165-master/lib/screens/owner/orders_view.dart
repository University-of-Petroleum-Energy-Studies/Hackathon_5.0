import 'package:WSHCRD/utils/global.dart';
import 'package:flutter/material.dart';

class OrdersView extends StatefulWidget {
  static const routeName = 'Orders';
  @override
  _OrdersViewState createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Orders'.toUpperCase(),
            style: TextStyle(color: kTitleColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          child: Center(
            child: Text(
              "No Orders to show",
            ),
          ),
        ),
      ),
    );
  }
}
