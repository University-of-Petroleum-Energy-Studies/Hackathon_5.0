import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:covid19/data/network/constants/endpoints.dart';
import 'package:covid19/icons/covid19_icons.dart';
import 'package:covid19/constants/strings.dart';
import 'package:covid19/constants/text_styles.dart';
import 'package:covid19/constants/colors.dart';
import 'package:covid19/constants/dimens.dart';
import 'package:covid19/utils/custom_scroll_behaviour.dart';
import 'package:covid19/utils/device/device_utils.dart';
import 'package:covid19/widgets/custom_alert_dialog.dart';


class InformationMobileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = DeviceUtils.getScaledWidth(context, 1);
    final screenHeight = DeviceUtils.getScaledHeight(context, 1);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          screenHeight / 20,
        ),
        child: AppBar(
          leading: Container(),
          backgroundColor: AppColors.transparentColor,
          elevation: 0,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                right: screenWidth / 50,
              ),
              child: GestureDetector(
                onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomAlertDialog(
                      title: RichText(
                        softWrap: true,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: '${Strings.dataSource}\n\n',
                            style: TextStyles.hightlightText.copyWith(
                              fontSize: screenHeight / 50,
                            ),
                          ),

                          TextSpan(
                            style: TextStyles.statisticsSubHeadingTextStlye
                                .copyWith(
                              fontSize: screenHeight / 60,
                            ),
                            children: <InlineSpan>[
                              const TextSpan(
                                text: Strings.informationSourceDescription,
                              ),
                              TextSpan(
                                text: Strings.blog,
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: AppColors.accentBlueColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async => await canLaunch(Endpoints
                                          .informationDataSourceReferenceURL)
                                      ? launch(Endpoints
                                          .informationDataSourceReferenceURL)
                                      : throw 'Could not launch Refernce URL',
                              ),
                              const TextSpan(
                                text: Strings.wby,
                              ),
                              TextSpan(
                                text: Strings.authorInformationGraphic,
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: AppColors.accentBlueColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async => await canLaunch(
                                          Endpoints.informationSourceAuthorURL)
                                      ? launch(
                                          Endpoints.informationSourceAuthorURL)
                                      : throw 'Could not launch Refernce URL',
                              ),
                            ],
                          ),
                        ]),
                      ),

                      actions: <Widget>[
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth / 25,
                              vertical: screenHeight / 75,
                            ),
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(-2, 4),
                                  blurRadius: 2,
                                  color: AppColors.boxShadowColor,
                                ),
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(screenWidth / 25),
                              ),
                              color: AppColors.accentBlueColor,
                            ),
                            child: Text(
                              'Close',
                              style: TextStyles.statisticsHeadingTextStlye
                                  .copyWith(
                                fontSize: screenHeight / 65,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                // Adding the information Icon to the [AppBar]
                child: Icon(
                  Covid19Icons.error,
                  size: screenHeight / 25,
                  color: AppColors.blackColor,
                ),
              ),
            ),
          ],
        ),
      ),

      body: ScrollConfiguration(
        behavior: const CustomScrollBehaviour(),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(
              bottom: Dimens.verticalPadding / 0.15,
            ),
            color: AppColors.preventionBackgroundColor,
            child: Image.asset(
              'assets/images/inf.jpg',
              fit: BoxFit.cover,
            ),
          ),
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
