import 'package:WSHCRD/locator.dart';
import 'package:WSHCRD/models/request.dart';
import 'package:WSHCRD/screens/customer/home/customer_home.dart';
import 'package:WSHCRD/screens/customer/nearby/nearby_view.dart';
import 'package:WSHCRD/screens/customer/profile/customer_edit_profile.dart';
import 'package:WSHCRD/screens/customer/profile/customer_profile.dart';
import 'package:WSHCRD/screens/customer/request/new_request.dart';
import 'package:WSHCRD/screens/customer/request/new_request_second.dart';
import 'package:WSHCRD/screens/customer/request/request_home.dart';
import 'package:WSHCRD/screens/customer/request/request_preview.dart';
import 'package:WSHCRD/screens/owner/categories.dart';
import 'package:WSHCRD/screens/owner/credit_book/add_customer.dart';
import 'package:WSHCRD/screens/owner/credit_book/credit_book.dart';
import 'package:WSHCRD/screens/owner/credit_book/get_or_give_payment.dart';
import 'package:WSHCRD/screens/owner/credit_book/payment_view.dart';
import 'package:WSHCRD/screens/owner/my_bids/my_bids.dart';
import 'package:WSHCRD/screens/owner/nearby/nearby_view.dart';
import 'package:WSHCRD/screens/owner/orders_view.dart';
import 'package:WSHCRD/screens/owner/owner_home_screen.dart';
import 'package:WSHCRD/screens/owner/profile/owner_edit_profile.dart';
import 'package:WSHCRD/screens/owner/profile/owner_profile.dart';
import 'package:WSHCRD/screens/signup/pick_location.dart';
import 'package:WSHCRD/screens/signup/signup_screen.dart';
import 'package:WSHCRD/screens/start.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Start.routeName:
        Start view = locator<Start>();
        return MaterialPageRoute(builder: (_) => view, settings: RouteSettings(name: Start.routeName));
      case AddCustomer.routeName:
        AddCustomer view = locator<AddCustomer>();
        return MaterialPageRoute(builder: (_) => view, settings: RouteSettings(name: AddCustomer.routeName));
      case CreditBook.routeName:
        CreditBook view = locator<CreditBook>();
        return MaterialPageRoute(builder: (_) => view, settings: RouteSettings(name: CreditBook.routeName));
      case GetOrGivePayment.routeName:
        GetOrGivePayment view = locator<GetOrGivePayment>();
        if (settings.arguments != null) {
          view.setValues(settings.arguments);
        }
        return MaterialPageRoute(builder: (_) => view, settings: RouteSettings(name: GetOrGivePayment.routeName));
      case PaymentView.routeName:
        PaymentView view = locator<PaymentView>();
        if (settings.arguments != null) {
          view.setValues(settings.arguments);
        }
        return MaterialPageRoute(builder: (_) => view, settings: RouteSettings(name: PaymentView.routeName));
      case SignUpScreen.routeName:
        SignUpScreen view = locator<SignUpScreen>();
        if (settings.arguments != null) {
          view.setValues(settings.arguments);
        }
        return MaterialPageRoute(builder: (_) => view, settings: RouteSettings(name: SignUpScreen.routeName));

      case MyBidsView.routeName:
        return MaterialPageRoute(
            builder: (_) => locator<MyBidsView>(), settings: RouteSettings(name: MyBidsView.routeName));
      case OrdersView.routeName:
        return MaterialPageRoute(
            builder: (_) => locator<OrdersView>(), settings: RouteSettings(name: OrdersView.routeName));

      case OwnerProfile.routeName:
        return MaterialPageRoute(
            builder: (_) => locator<OwnerProfile>(), settings: RouteSettings(name: OwnerProfile.routeName));
      case OwnerHomeScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => locator<OwnerHomeScreen>(), settings: RouteSettings(name: OwnerHomeScreen.routeName));
      case OwnerNearByView.routeName:
        return MaterialPageRoute(
            builder: (_) => locator<OwnerNearByView>(), settings: RouteSettings(name: OwnerNearByView.routeName));
      case OwnerEditProfile.routeName:
        return MaterialPageRoute(
            builder: (_) => locator<OwnerEditProfile>(), settings: RouteSettings(name: OwnerEditProfile.routeName));
      case CustomerEditProfile.routeName:
        return MaterialPageRoute(
            builder: (_) => locator<CustomerEditProfile>(),
            settings: RouteSettings(name: CustomerEditProfile.routeName));
      case Categories.routeName:
        return MaterialPageRoute(
            builder: (_) => locator<Categories>(), settings: RouteSettings(name: Categories.routeName));
      case PickLocation.routeName:
        return MaterialPageRoute(
            builder: (_) => locator<PickLocation>(), settings: RouteSettings(name: PickLocation.routeName));
      case CustomerHomeScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => locator<CustomerHomeScreen>(), settings: RouteSettings(name: CustomerHomeScreen.routeName));
      case NewRequestView.routeName:
        return MaterialPageRoute(
            builder: (_) => locator<NewRequestView>(), settings: RouteSettings(name: NewRequestView.routeName));
      case NewRequestSecondView.routeName:
        NewRequestSecondView view = locator<NewRequestSecondView>();
        if (settings.arguments != null) {
          Map<String, dynamic> values = settings.arguments;
          view.setRequest(Request.fromJson(values));
        }
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => view,
          settings: RouteSettings(name: NewRequestSecondView.routeName),
          transitionsBuilder: (_, anim, __, child) {
            return FadeTransition(opacity: anim, child: child);
          },
        );

//        return MaterialPageRoute(
//            builder: (_) => view,
//            settings: RouteSettings(name: NewRequestSecondView.routeName));
      case RequestPreviewView.routeName:
        RequestPreviewView view = locator<RequestPreviewView>();
        if (settings.arguments != null) {
          Map<String, dynamic> values = settings.arguments;
          view.setRequest(Request.fromJson(values));
        }
        return MaterialPageRoute(builder: (_) => view, settings: RouteSettings(name: RequestPreviewView.routeName));
      case RequestHomeView.routeName:
        return MaterialPageRoute(
            builder: (_) => locator<RequestHomeView>(), settings: RouteSettings(name: RequestHomeView.routeName));

      case CustomerNearByView.routeName:
        return MaterialPageRoute(
            builder: (_) => locator<CustomerNearByView>(), settings: RouteSettings(name: CustomerNearByView.routeName));

      case CustomerProfileView.routeName:
        return MaterialPageRoute(
            builder: (_) => locator<CustomerProfileView>(),
            settings: RouteSettings(name: CustomerProfileView.routeName));

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
