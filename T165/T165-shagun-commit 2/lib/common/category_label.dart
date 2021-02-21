import 'package:flutter/material.dart';

class CategoryLabel extends StatefulWidget {
  String label;
  TextStyle textStyle;
  double borderWidth;
  Color fillColor;

  CategoryLabel(this.label, {this.textStyle, this.borderWidth = 2, this.fillColor = Colors.white});

  @override
  _CategoryLabelState createState() => _CategoryLabelState();
}

class _CategoryLabelState extends State<CategoryLabel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            fit: FlexFit.loose,
            child: Center(
              child: Text(
                widget.label,
                style: this.widget.textStyle ?? TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: widget.fillColor,
        border: Border.all(color: Colors.black, width: this.widget.borderWidth),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}
