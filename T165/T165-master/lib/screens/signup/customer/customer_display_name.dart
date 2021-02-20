import 'package:WSHCRD/common/locatization.dart';
import 'package:flutter/material.dart';

class CustomerDisplayName extends StatefulWidget {
  Function customerDisplayName;
  CustomerDisplayName({Key key, this.customerDisplayName}) : super(key: key);

  @override
  _CustomerDisplayNameState createState() => _CustomerDisplayNameState();
}

class _CustomerDisplayNameState extends State<CustomerDisplayName> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 30,
        right: 10,
        left: 10,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  AppLocalizations.of(context)
                      .translate('get_started_enter_display_name'),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 20, bottom: 15),
            child: TextFormField(
              onChanged: (value) {
                // Customer Diplay Name
                widget.customerDisplayName(value);
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 5),
                hintText: AppLocalizations.of(context)
                    .translate('enter_display_name'),
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.5),
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
