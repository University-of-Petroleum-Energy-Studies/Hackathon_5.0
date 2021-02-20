import 'package:WSHCRD/common/locatization.dart';
import 'package:flutter/material.dart';

class BusinessOrCustomer extends StatefulWidget {
  Function businessOrNot;
  BusinessOrCustomer({Key key, this.businessOrNot}) : super(key: key);

  @override
  _BusinessOrCustomerState createState() => _BusinessOrCustomerState();
}

class _BusinessOrCustomerState extends State<BusinessOrCustomer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Text(
            AppLocalizations.of(context).translate('business_question'),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 75,
          ),
          InkWell(
            onTap: () {
              widget.businessOrNot(1);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 3 / 5,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.black, width: 2)),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).translate('yes'),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              widget.businessOrNot(0);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 3 / 5,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.black, width: 2)),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).translate('no'),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
