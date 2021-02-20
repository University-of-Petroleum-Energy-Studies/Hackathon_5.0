import 'package:covid19/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:covid19/constants/app_theme.dart';
import 'package:covid19/constants/strings.dart';
import 'package:covid19/data/repository/base_repository.dart';
import 'package:covid19/data/repository/user_repository.dart';
import 'package:covid19/stores/statistics/statistics_notifier.dart';
import 'package:flutter/services.dart';
import 'package:custom_splash/custom_splash.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CustomSplash(
      imagePath: 'assets/images/icon.png',
      backGroundColor: themeData.primaryColor,
      animationEffect: 'zoom-in',
      logoSize: 200,
      home: MyApp(),
      duration: 3000,
      type: CustomSplashType.StaticDuration,
    ),
  ));

  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
}

class MyApp extends StatelessWidget {
  final BaseRepository repository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StatisticsChangeNotifier(
        userRepository: repository,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Strings.appName,
        theme: themeData,
        routes: Routes.routes,
      ),
    );
  }
}
