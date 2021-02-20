import 'package:flutter/material.dart';
import 'package:covid19/ui/home/home_screen.dart';
import 'package:covid19/ui/statistics/statistics_screen.dart';
import 'package:covid19/ui/prevention/prevention_screen.dart';
import 'package:covid19/ui/symptoms/symptoms_screen.dart';
import 'package:covid19/ui/information/information_screen.dart';
import 'package:covid19/routes/health/health.dart';
import 'package:covid19/routes/homepage.dart';




class Routes {
  Routes._();

  //static variables
  static const String home = '/';
  static const String statistics = '/statistics';
  static const String prevention = '/prevention';
  static const String symptoms = '/symptoms';
  static const String mythBusters = '/myth-busters';
  static const String faq = '/faq';
  static const String covid19Information = '/covid-19-information';
  static const String map = '/map';
  static const String nearby = '/nearby';
  static const String news = '/news';
  static const String notes = '/notes';
  static const String water = '/water';
  static const String checkup = '/checkup';



  static final Map routes = <String, WidgetBuilder>{
    home: (BuildContext context) => HomeScreen(),
    statistics: (BuildContext context) => StatisticsScreen(),
    prevention: (BuildContext context) => PreventionScreen(),
    symptoms: (BuildContext context) => SymptomsScreen(),
    covid19Information: (BuildContext context) => InformationScreen(),
    checkup: (BuildContext context) => HomePage(),


  };
}
