import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:covid19/routes.dart';
import 'package:covid19/data/network/constants/endpoints.dart';
import 'package:covid19/icons/covid19_icons.dart';
import 'package:covid19/constants/colors.dart';
import 'package:covid19/constants/dimens.dart';
import 'package:covid19/constants/strings.dart';
import 'package:covid19/constants/text_styles.dart';
import 'package:covid19/ui/home/widgets/home_card_mobile_widget.dart';
import 'package:covid19/utils/custom_scroll_behaviour.dart';
import 'package:covid19/utils/device/device_utils.dart';
import 'package:covid19/widgets/custom_alert_dialog.dart';
import 'package:covid19/widgets/sized_box_height_widget.dart';
import 'package:alan_voice/alan_voice.dart';


class HomeMobileScreen extends StatefulWidget {
  @override
  _HomeMobileScreenState createState() => _HomeMobileScreenState();
}

class _HomeMobileScreenState extends State<HomeMobileScreen> {
  @override
  void initState()  {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = DeviceUtils.getScaledWidth(context, 1);
    final screenHeight = DeviceUtils.getScaledHeight(context, 1);
    return Material(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: AppBar(
            backgroundColor: AppColors.transparentColor,
            brightness: Brightness.light,
            elevation: 0.0,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              Dimens.horizontalPadding,
              Dimens.verticalPadding / 0.75,
              Dimens.horizontalPadding,
              Dimens.verticalPadding / 0.5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Page Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Page Title
                    Text(
                      Strings.appSlogan,
                      style: TextStyles.statisticsHeadingTextStlye.copyWith(
                          fontSize: screenHeight / 30,
                          fontFamily: 'pSans'
                      ),
                    ),

                    // Information Icon
                    GestureDetector(
                      onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomAlertDialog(
                            title: RichText(
                              softWrap: true,
                              text: TextSpan(children: <TextSpan>[
                                // Dialog Title - Data Source
                                TextSpan(
                                  text:
                                  '${Strings.projectDetailsHeading}\n\n',
                                  style: TextStyles.hightlightText.copyWith(
                                      fontSize: screenHeight / 50,
                                      fontFamily: 'pSans'
                                  ),
                                ),

                                TextSpan(
                                  style: TextStyles
                                      .statisticsSubHeadingTextStlye
                                      .copyWith(
                                      fontSize: screenHeight / 60,
                                      fontFamily: 'pSans'
                                  ),
                                  children: <InlineSpan>[
                                    const TextSpan(
                                      text: Strings.projectDetails,
                                    ),
                                    TextSpan(
                                      text: Strings.ghb,
                                      style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: AppColors.accentBlueColor,
                                      ),

                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async => await canLaunch(
                                            Endpoints
                                                .bgr)
                                            ? launch(Endpoints
                                            .bgr)
                                            : throw 'Could not launch Refernce URL',
                                    ),
                                  ],
                                ),
                              ]),
                            ),

                            // Defining the Action item [Close] for the Dialog
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
                                      Radius.circular(screenHeight / 75),
                                    ),
                                    color: AppColors.accentBlueColor,
                                  ),
                                  child: Text(
                                    'Close',
                                    style: TextStyles
                                        .statisticsHeadingTextStlye
                                        .copyWith(
                                        fontSize: screenHeight / 65,
                                        fontFamily: 'pSans'
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      child: Icon(
                        Covid19Icons.error,
                        size: screenHeight / 25,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),

                // Vertical Spacing
                SizedBoxHeightWidget(screenHeight / 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/home.png',
                      fit: BoxFit.contain,
                    ),
                  ],
                ),


                Row(
                  children: const <Widget>[
                    // Statistics Card
                    Expanded(
                      flex: 1,
                      child: HomeCardWidget(
                        backgroundColor: AppColors.primaryColor,
                        title: Strings.covidInformationTitle,
                        imagePath: '${Endpoints.baseUrlGraphics}/virus.png',
                        route: Routes.covid19Information,
                      ),
                    ),

                    // Prevention Numbers Card
                    Expanded(
                      flex: 1,
                      child: HomeCardWidget(
                        backgroundColor: AppColors.primaryColor,
                        title: Strings.statisticsTitle,
                        imagePath:
                        '${Endpoints.baseUrlGraphics}/statistics.png',
                        route: Routes.statistics,
                      ),
                    ),

                    // Symptoms Card
                    Expanded(
                      flex: 1,
                      child: HomeCardWidget(
                        backgroundColor: AppColors.primaryColor,
                        title: Strings.preventionTitle,
                        imagePath:
                        '${Endpoints.baseUrlGraphics}/prevention.png',
                        route: Routes.prevention,
                      ),
                    ),
                  ],
                ),

                // Vertical Spacing
                SizedBoxHeightWidget(screenHeight / 125),

                Row(
                  children: const <Widget>[
                    Expanded(
                      flex: 1,
                      child: HomeCardWidget(
                        backgroundColor: AppColors.primaryColor,
                        title: Strings.symptomsTitle,
                        imagePath:
                        '${Endpoints.baseUrlGraphics}/symptoms.png',
                        route: Routes.symptoms,
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: HomeCardWidget(
                        backgroundColor: AppColors.primaryColor,
                        title: Strings.mythBusterTitle,
                        imagePath:
                        '${Endpoints.baseUrlGraphics}/myth-busters.png',
                        route: Routes.mythBusters,
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: HomeCardWidget(
                        backgroundColor: AppColors.primaryColor,
                        title: Strings.notesTitle,
                        imagePath:
                        '${Endpoints.baseUrlGraphics}/notes.png',
                        route: Routes.notes,
                      ),
                    ),


                  ],
                ),

                SizedBoxHeightWidget(screenHeight / 125),

                Row(
                  children: const <Widget>[
                    // Myth Busters Card
                    Expanded(
                      flex: 1,
                      child: HomeCardWidget(
                        backgroundColor: AppColors.primaryColor,
                        title: 'Live Heat Map',
                        imagePath:
                        '${Endpoints.baseUrlGraphics}/map.png',
                        route: Routes.map,
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: HomeCardWidget(
                        backgroundColor: AppColors.primaryColor,
                        title: 'Self Assessment',
                        imagePath:
                        '${Endpoints.baseUrlGraphics}/hospital.png',
                        route: Routes.checkup,
                      ),
                    ),


                    Expanded(
                      flex: 1,
                      child: HomeCardWidget(
                        backgroundColor: AppColors.primaryColor,
                        title: 'News',
                        imagePath:
                        '${Endpoints.baseUrlGraphics}/news.png',
                        route: Routes.news,
                      ),
                    )

                  ],
                ),

                SizedBoxHeightWidget(screenHeight / 125),


              ],
            ),
          ),
        ),

      ),
    );
  }
}
