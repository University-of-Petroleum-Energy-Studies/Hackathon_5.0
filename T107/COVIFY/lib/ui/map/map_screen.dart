import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:covid19/ui/map//map_screen_mobile.dart';
//import 'package:covid19/ui/map//map_screen_desktop.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTypeLayout.builder(
        mobile: (BuildContext context) => MapScreenMobile(),
        //desktop: (BuildContext context) => MapScreenDesktop(),
      ),
    );
  }
}
