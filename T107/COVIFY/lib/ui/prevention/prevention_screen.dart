import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:covid19/ui/prevention/prevention_screen_mobile.dart';
import 'package:covid19/ui/prevention/prevention_screen_desktop.dart';

class PreventionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTypeLayout.builder(
        mobile: (BuildContext context) => PreventionMobileScreen(),
        desktop: (BuildContext context) => PreventionDesktopScreen(),
      ),
    );
  }
}
