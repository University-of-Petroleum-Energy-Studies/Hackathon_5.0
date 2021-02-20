import 'package:WSHCRD/firebase_services/owner_controller.dart';
import 'package:WSHCRD/models/customer.dart';
import 'package:WSHCRD/models/ledger.dart';
import 'package:WSHCRD/screens/owner/credit_book/payment_view.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as flutterLoc;

class Global {
  static const OWNER = "owner";
  static const CUSTOMER = "customer";
  static const appName = "SHAGUN";

  static void showToastMessage(
      {@required context: BuildContext, @required msg: String}) {
    BotToast.showText(text: msg);
  }

  static final String dateTimeFormat = "MM-dd-yyyy HH:mm:ss";

  static Future<flutterLoc.LocationData> getLocation() async {
    flutterLoc.Location location = flutterLoc.Location();

    bool _serviceEnabled;
    flutterLoc.PermissionStatus _permissionGranted;
    flutterLoc.LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == flutterLoc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != flutterLoc.PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }
}

Color kCreditColor = Color(0xff1F853C);
Color kDebitColor = Colors.red; //Color(0xffA51C12);
Color kBorderColor = Colors.black54;
Color kBorderColorLight = Colors.black38;
Color kTitleColor = Colors.grey[600];
Color kGreenColor = Color(0xff18d29f);

const Color kDefaultColorSlab = Color(0xffffdbda);
List<Color> kColorSlabs = [
  Color(0xffffdbda),
  Color(0xffffc49b),
  Color(0xff7bfeb8),
  Color(0xffcfffb0),
  Color(0xfffefcad),
];

List<double> kRadiusList = [0.5, 1, 3, 6];
List<String> kRadiusListText = ['500 M', '1 KM', '3 KM', '6 KM'];

DateTime getYesterdayTime() {
  return DateTime.now().toUtc().subtract(Duration(hours: 24));
}

showLoadingScreen() {
  BotToast.showLoading(clickClose: true);
}

closeLoadingScreen() {
  BotToast.closeAllLoading();
}

Future<void> addNewCustomer(
    BuildContext context, String displayName, String phoneNumber,
    {bool popAndPush = true}) async {
  showLoadingScreen();
  Customer customer = Customer();
  customer.displayName = displayName;
  customer.phoneNumber = phoneNumber;
  DateTime date = DateTime.now().toUtc();
  customer.creationDateInEpoc = date.millisecondsSinceEpoch;
  customer.creationDate = DateFormat(Global.dateTimeFormat).format(date);
  Ledger ledger = await OwnerController.addCustomer(customer);
  closeLoadingScreen();
  if (ledger != null) {
    BotToast.showText(text: 'Customer added successfully');
    if (popAndPush) {
      Navigator.popAndPushNamed(context, PaymentView.routeName, arguments: {
        'color': kColorSlabs[0].value,
        'customerId': ledger.customerId,
        'customerName': customer.displayName,
        'ledgerId': ledger.ledgerId
      });
    } else {
      Navigator.pushNamed(context, PaymentView.routeName, arguments: {
        'color': kColorSlabs[0].value,
        'customerId': ledger.customerId,
        'customerName': customer.displayName,
        'ledgerId': ledger.ledgerId
      });
    }
  } else {
    BotToast.showText(text: 'Unable to add Customer');
  }
}
