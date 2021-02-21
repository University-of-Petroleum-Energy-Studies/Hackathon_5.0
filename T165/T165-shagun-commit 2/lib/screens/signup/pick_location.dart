import 'package:WSHCRD/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

class PickLocation extends StatefulWidget {
  static const routeName = 'PickLocation';

  const PickLocation({Key key}) : super(key: key);

  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  _PickLocationState createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: ThemeData.dark().copyWith(
          // Background color of the FloatingCard
          cardColor: kBorderColor,
          buttonTheme: ButtonThemeData(
            // Select here's button color
            buttonColor: kGreenColor,
            textTheme: ButtonTextTheme.normal,
          ),
        ),
        child: PlacePicker(
          apiKey: "AIzaSyC0hqw1hgz5CPQ7XtjonneyYa3R4QA4kWc",
          // CHANGE THIS LATER ON
          // apiKey: "AIzaSyCCDumWcqvJQ3306SvWcUFmA8Ixp92XrA4", // CHANGE THIS LATER ON
          initialPosition: PickLocation.kInitialPosition,
          useCurrentLocation: true,
          selectInitialPosition: true,
          searchForInitialValue: true,
          usePlaceDetailSearch: true,
          onPlacePicked: (result) {
            Navigator.pop(context, result);
          },
        ),
      ),
    );
  }
}
