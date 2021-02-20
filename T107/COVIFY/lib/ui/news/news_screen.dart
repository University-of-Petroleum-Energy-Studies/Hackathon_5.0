import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:covid19/ui/news/news_screen_mobile.dart';
import 'package:covid19/ui/news//news_screen_desktop.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTypeLayout.builder(
        mobile: (BuildContext context) => NewsScreenMobile(),
        desktop: (BuildContext context) => NewsScreenDesktop(),
      ),
    );
  }
}
