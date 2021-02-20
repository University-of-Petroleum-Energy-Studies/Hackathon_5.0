import 'package:flutter/material.dart';
import 'package:covid19/constants/colors.dart';
import 'package:covid19/ui/home/home_screen.dart';
import 'package:covid19/ui/statistics/statistics_screen.dart';
import 'package:covid19/ui/prevention/prevention_screen.dart';
import 'package:covid19/ui/symptoms/symptoms_screen.dart';
import 'package:covid19/ui/mythBusters/myth_busters_screen.dart';
import 'package:covid19/ui/faq/faq_screen.dart';
import 'package:covid19/ui/information/information_screen.dart';

enum HomeRoutes {
  home,
  latestNumbers,
  prevention,
  symptomChecker,
  symptoms,
  mythBusters,
  faq,
  information,
}


extension HomeRouteDefinitions on HomeRoutes {
  String get name {
    switch (this) {
      case HomeRoutes.home:
        return '/';
      case HomeRoutes.latestNumbers:
        return '/latest-numbers';
      case HomeRoutes.prevention:
        return '/prevention';
      case HomeRoutes.symptoms:
        return '/symptoms';
      case HomeRoutes.mythBusters:
        return '/myth-busters';
      case HomeRoutes.faq:
        return '/faq';
      case HomeRoutes.information:
        return '/information';
      default:
        return '/';
    }
  }

  static HomeRoutes fromString(String str) {
    switch (str) {
      case '/':
        return HomeRoutes.home;
      case '/latest-numbers':
        return HomeRoutes.latestNumbers;
      case '/prevention':
        return HomeRoutes.prevention;
      case '/symptom-checker':
        return HomeRoutes.symptomChecker;
      case '/symptoms':
        return HomeRoutes.symptoms;
      case '/myth-busters':
        return HomeRoutes.mythBusters;
      case '/faq':
        return HomeRoutes.faq;
      case '/information':
        return HomeRoutes.information;
      default:
        return HomeRoutes.home;
    }
  }
}

class HomeRouter {
  static List<String> routesStack = [];

  static Route<dynamic> generateRoute(
    RouteSettings settings,
  ) {
    routesStack.add(settings.name);
    switch (HomeRouteDefinitions.fromString(settings.name)) {
      case HomeRoutes.home:
        return CustomPageRoute(HomeScreen());
      case HomeRoutes.latestNumbers:
        return MaterialPageRoute(
            builder: (_) => StatisticsScreen(), settings: settings);
      case HomeRoutes.prevention:
        return MaterialPageRoute(
            builder: (_) => PreventionScreen(), settings: settings);
      case HomeRoutes.symptoms:
        return MaterialPageRoute(
            builder: (_) => SymptomsScreen(), settings: settings);
      case HomeRoutes.mythBusters:
        return MaterialPageRoute(
            builder: (_) => MythBustersScreen(), settings: settings);
      case HomeRoutes.faq:
        return MaterialPageRoute(
            builder: (_) => FAQScreen(), settings: settings);
      case HomeRoutes.information:
        return MaterialPageRoute(
            builder: (_) => InformationScreen(), settings: settings);

      default:
        return CustomPageRoute(HomeScreen());
    }
  }
}


class HomeNavigator extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  final HeroController _heroController = HeroController();

  // Convenience static method for extended functionality
  static void pop(BuildContext context) {
    HomeRouter.routesStack.removeLast();
    navigatorKey.currentState.pop();
  }

  @override
  Widget build(BuildContext context) {
    // Handle the BackButton for the sub-navigator
    return WillPopScope(
      onWillPop: () async {
        if (HomeRouter.routesStack.length == 1) {
          return true;
        }
        HomeRouter.routesStack.removeLast();
        navigatorKey.currentState.pop();
        return false;
      },
      child: Navigator(
        key: navigatorKey,
        observers: [_heroController],
        initialRoute: HomeRoutes.home.name,
        onGenerateRoute: (settings) => HomeRouter.generateRoute(settings),
      ),
    );
  }
}

class CustomPageRoute<T> extends PageRoute<T> {
  CustomPageRoute(this.child);
  @override
  // TODO: implement barrierColor
  Color get barrierColor => AppColors.primaryColor;

  @override
  String get barrierLabel => null;

  final Widget child;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    // return child;
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);
}
