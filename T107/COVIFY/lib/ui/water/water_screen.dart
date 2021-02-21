import 'package:flutter/material.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:covid19/ui/water/water_screen_mobile.dart';

class WaterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTypeLayout.builder(
        mobile: (BuildContext context) => WaterScreenMobile(),
      ),
    );
  }
}