import 'package:flutter/material.dart';
import 'package:covid19/data/symptoms_data.dart';
import 'package:covid19/icons/covid19_icons.dart';
import 'package:covid19/constants/strings.dart';
import 'package:covid19/constants/text_styles.dart';
import 'package:covid19/constants/colors.dart';
import 'package:covid19/constants/dimens.dart';
import 'package:covid19/ui/symptoms/widgets/symptom_card_widget_mobile.dart';
import 'package:covid19/utils/device/device_utils.dart';
import 'package:covid19/utils/custom_scroll_behaviour.dart';
import 'package:covid19/widgets/sized_box_height_widget.dart';


class SymptomsMobileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = DeviceUtils.getScaledHeight(context, 1);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: AppColors.whiteColor,
          brightness: Brightness.light,
          elevation: 0.0,
        ),
      ),

      // Wrapping the contents in [SafeArea] to avoid the Notch (When avaiable) and the bottom
      // navigation bar (Mostly comes in use for iOS Devices)
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Dimens.horizontalPadding,
            Dimens.verticalPadding / 0.75,
            Dimens.horizontalPadding,
            0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Back Icon
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(
                        Covid19Icons.keyboardArrowLeft,
                        size: screenHeight / 45,
                        color: AppColors.blackColor,
                      ),
                    ),

                    // Vertical Spacing
                    SizedBoxHeightWidget(screenHeight / 50),

                    // Page Title
        Center(
                    child: Text(
                      Strings.symptomsTitle,
                      style: TextStyles.statisticsHeadingTextStlye.copyWith(
                        fontSize: screenHeight / 35,
                          fontFamily: 'pSans'
                      ),
                      textAlign: TextAlign.center,
                    ),
        ),

                    // Vertical Spacing
                    SizedBoxHeightWidget(screenHeight / 25),
                  ],
                ),
              ),


              Expanded(
                flex: 6,
child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: symptomsData.length,
                    itemBuilder: (context, index) {
                      // Adding extra padding at the bottom in case of the last element
                      if (index == symptomsData.length - 1) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: Dimens.verticalPadding,
                          ),
                          child: SymptomCardMobileWidget(
                            title: symptomsData[index].title,
                            description: symptomsData[index].description,
                            imageURL: symptomsData[index].imageURL,
                          ),
                        );
                      }
                      return SymptomCardMobileWidget(
                        title: symptomsData[index].title,
                        description: symptomsData[index].description,
                        imageURL: symptomsData[index].imageURL,
                      );
                    },
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}
