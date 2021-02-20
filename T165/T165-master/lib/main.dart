import 'dart:async';

import 'package:WSHCRD/common/locatization.dart';
import 'package:WSHCRD/firebase_services/auth_controller.dart';
import 'package:WSHCRD/locator.dart';
import 'package:WSHCRD/router.dart';
import 'package:WSHCRD/screens/customer/home/customer_home.dart';
import 'package:WSHCRD/screens/owner/owner_home_screen.dart';
import 'package:WSHCRD/screens/start.dart';
import 'package:WSHCRD/utils/global.dart';
import 'package:WSHCRD/utils/session_controller.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Crashlytics.instance.enableInDevMode = true;
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  SessionController.initialize(sharedPreferences);
  FirebaseUser user = await AuthController.getCurrentUser();
  String userType = SessionController.getUserType();
  setupLocator();
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runZonedGuarded(() {
    runApp(MyApp(user, userType));
  }, Crashlytics.instance.recordError);
}

class MyApp extends StatelessWidget {
  final FirebaseUser user;
  final String userType;

  MyApp(this.user, this.userType);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.black,
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
        appBarTheme: AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(
            color: kTitleColor, //change yo// ur color here
          ),
        ),
      ),
      builder: BotToastInit(),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English, no country code
        // ... other locales the app supports
      ],
      onGenerateRoute: Router.generateRoute,
      initialRoute: getInitialRoute(),
    );
  }

  getInitialRoute() {
    if (user != null) {
      if (userType != null) {
        if (userType == Global.OWNER) {
          return OwnerHomeScreen.routeName;
        } else if (userType == Global.CUSTOMER) {
          return CustomerHomeScreen.routeName;
        } else {
          return Start.routeName;
        }
      } else {
        return Start.routeName;
      }
    } else {
      return Start.routeName;
    }
  }
}
