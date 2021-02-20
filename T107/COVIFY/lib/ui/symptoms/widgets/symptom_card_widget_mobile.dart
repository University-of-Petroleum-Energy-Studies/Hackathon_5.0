import 'package:covid19/constants/colors.dart';
import 'package:covid19/constants/text_styles.dart';
import 'package:covid19/utils/device/device_utils.dart';
import 'package:covid19/widgets/sized_box_height_widget.dart';
import 'package:flutter/material.dart';


class SymptomCardMobileWidget extends StatelessWidget {
  final String title, description, imageURL;

  const SymptomCardMobileWidget({
    Key key,
    @required this.title,
    @required this.description,
    @required this.imageURL,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenWidth = DeviceUtils.getScaledWidth(context, 1);
    final screenHeight = DeviceUtils.getScaledHeight(context, 1);
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: screenWidth / 1.25,
            margin: EdgeInsets.only(
              right: 5,
              top: 2,
              bottom: screenHeight / 45,
            ),
            padding: EdgeInsets.only(
              left: screenWidth / 10,
              top: screenHeight / 50,
              right: screenWidth / 25,
              bottom: screenHeight / 30,
            ),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(1, 1),
                  blurRadius: 5,
                  color: AppColors.boxShadowColor,
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: AppColors.whiteColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyles.statisticsHeadingTextStlye.copyWith(
                    fontSize: screenHeight / 45,
                      fontFamily: 'pSans'
                  ),
                ),

                // Vertical Spacing
                SizedBoxHeightWidget(screenHeight / 75),

                Text(
                  description,
                  style: TextStyles.statisticsSubHeadingTextStlye.copyWith(
                    fontSize: screenHeight / 55,
                      fontFamily: 'pSans'
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
              top: screenHeight / 50,
            ),
            child: Image.asset(
              imageURL,
              height: screenHeight / 10,
              fit: BoxFit.cover,

                  width: screenHeight / 10,

            ),
          ),
        )
      ],
    );
  }
}
