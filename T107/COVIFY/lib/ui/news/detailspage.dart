import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:covid19/constants/strings.dart';
import 'package:covid19/constants/text_styles.dart';
import 'package:covid19/constants/colors.dart';
import 'package:covid19/constants/dimens.dart';
import 'package:covid19/utils/custom_scroll_behaviour.dart';
import 'package:covid19/utils/device/device_utils.dart';
import 'package:covid19/widgets/custom_alert_dialog.dart';
import 'package:covid19/icons/covid19_icons.dart';


class DetailsPage extends StatefulWidget {
  String title, author, urlToImage, publishedAt, description;

  DetailsPage(
      {this.title,
        this.author,
        this.description,
        this.publishedAt,
        this.urlToImage});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  @override
  Widget build(BuildContext context) {
    final screenWidth = DeviceUtils.getScaledWidth(context, 1);
    final screenHeight = DeviceUtils.getScaledHeight(context, 1);
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: <Widget>[
            Image.network(
              widget.urlToImage,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 350.0, 0.0, 0.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Material(
                  borderRadius: BorderRadius.circular(35.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 30.0,
                            fontFamily: 'pSans',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          widget.description,
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),

      ),

      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: screenHeight / 75,
        ),
        child: FloatingActionButton.extended(
          onPressed: () => Navigator.of(context).pop(),
          backgroundColor: AppColors.blackColor,
          isExtended: true,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          icon: Icon(
            Covid19Icons.keyboardArrowLeft,
            size: screenHeight / 45,
            color: AppColors.offBlackColor,
          ),
          label: const Text(
            'Go Back',
            style: TextStyles.infoLabelTextStyle,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}