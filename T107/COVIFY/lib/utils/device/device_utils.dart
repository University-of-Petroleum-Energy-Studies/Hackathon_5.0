import 'package:flutter/material.dart';


class DeviceUtils {

  static void hideKeyboard(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }


  static double getScaledSize(BuildContext context, double scale) =>
      scale *
      (MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.height);


  static double getScaledWidth(BuildContext context, double scale) =>
      scale * MediaQuery.of(context).size.width;


  static double getScaledHeight(BuildContext context, double scale) =>
      scale * MediaQuery.of(context).size.height;

  static double getFractionFromHeight(
          BuildContext context, double scaledHeight) =>
      scaledHeight / MediaQuery.of(context).size.height;
}
