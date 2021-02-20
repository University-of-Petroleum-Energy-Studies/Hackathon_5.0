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


class InformationDesktopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = DeviceUtils.getScaledWidth(context, 1);
    final screenHeight = DeviceUtils.getScaledHeight(context, 1);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          screenHeight / 15,
        ),
        child: AppBar(
          leading: Container(),
          backgroundColor: AppColors.transparentColor,
          elevation: 0,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                right: screenWidth / 250,
              ),
              child: GestureDetector(
                // image
                onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomAlertDialog(
                      title: SizedBox(
                        width: screenHeight / 3.5,
                        child: RichText(
                          softWrap: true,
                          text: TextSpan(children: <TextSpan>[
                            // Dialog Title - Data Source
                            TextSpan(
                              text: '${Strings.dataSource}\n\n',
                              style: TextStyles.hightlightText.copyWith(
                                fontSize: screenHeight / 30,
                              ),
                            ),

                            // Dialog description referncing and linking the blog post
                            // and the Author
                            TextSpan(
                              style: TextStyles.statisticsSubHeadingTextStlye
                                  .copyWith(
                                fontSize: screenHeight / 35,
                              ),
                              children: <InlineSpan>[
                                const TextSpan(
                                  text: Strings.informationSourceDescription,
                                ),
                                TextSpan(
                                  text: Strings.blog,
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
                                            Endpoints
                                                .informationSourceAuthorURL)
                                        ? launch(Endpoints
                                            .informationSourceAuthorURL)
                                        : throw 'Could not launch Refernce URL',
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),

                      // Defining the Action item [Close] for the Dialog
                      actions: <Widget>[
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth / 75,
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
                                Radius.circular(screenHeight / 50),
                              ),
                              color: AppColors.accentBlueColor,
                            ),
                            child: Text(
                              'Close',
                              style: TextStyles.statisticsHeadingTextStlye
                                  .copyWith(
                                fontSize: screenHeight / 35,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                // Adding the information Icon to the [AppBar]
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(screenWidth / 15),
                    ),
                  ),
                  child: Icon(
                    Covid19Icons.error,
                    size: screenHeight / 18,
                    color: AppColors.blackColor,
                  ),
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
            child: Image.network(
              Endpoints.fetchInformatiionGraphic,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: screenWidth,
                  height: screenHeight,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(100, 105, 105, 105)),
                  child: FittedBox(
                    fit: BoxFit.none,
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: const Padding(
                          padding: EdgeInsets.all(25.0),
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.accentColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
