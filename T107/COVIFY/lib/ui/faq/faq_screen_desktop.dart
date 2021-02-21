import 'package:flutter/material.dart';
import 'package:covid19/constants/colors.dart';
import 'package:covid19/constants/dimens.dart';
import 'package:covid19/constants/strings.dart';
import 'package:covid19/constants/text_styles.dart';
import 'package:covid19/data/faq_data.dart';
import 'package:covid19/models/faq/faq_model.dart';
import 'package:covid19/utils/custom_scroll_behaviour.dart';
import 'package:covid19/utils/device/device_utils.dart';
import 'package:covid19/widgets/sized_box_height_widget.dart';

/// [FAQDesktopScreen] is used to display the list of FAQ Questions to the user
/// Supports Desktop Screen Sizes
class FAQDesktopScreen extends StatefulWidget {
  @override
  _FAQDesktopScreenState createState() => _FAQDesktopScreenState();
}

class _FAQDesktopScreenState extends State<FAQDesktopScreen> {

  @override
  Widget build(BuildContext context) {
    final screenHeight = DeviceUtils.getScaledHeight(context, 1);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      // [AppBar] with 0 size used to set the statusbar background color and
      // statusbat text/icon color
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: AppColors.transparentColor,
          brightness: Brightness.light,
          elevation: 0.0,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Dimens.horizontalPadding,
            Dimens.verticalPadding / 0.75,
            Dimens.horizontalPadding,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // FAQ Headers
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Page Title
                    Text(
                      Strings.faqTitle,
                      style: TextStyles.statisticsHeadingTextStlye.copyWith(
                        fontSize: screenHeight / 35,
                          fontFamily: 'pSans'
                      ),
                    ),
                  ],
                ),
              ),


              Flexible(
                flex: 15,
                child: ScrollConfiguration(
                  behavior: const CustomScrollBehaviour(),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Running a for loop from item 0 to item n-1
                        for (int index = 0;
                            index < faqData.length - 1;
                            index++) ...[
                          // Adding a Row of 2 [FAQItem] with a [Spacer] in between
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 20,
                                child: FAQItem(
                                  faqData[index],
                                ),
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              Expanded(
                                flex: 20,
                                child: FAQItem(
                                  faqData[index + 1],
                                ),
                              ),
                            ],
                          ),

                          // Vertical Spacing
                          SizedBoxHeightWidget(screenHeight / 75),
                        ]
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class FAQItem extends StatefulWidget {
  final FAQModel entry;

  const FAQItem(this.entry);

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: PageStorageKey<FAQModel>(widget.entry),
      initiallyExpanded: widget.entry.isExpanded,
      title: Text(
        widget.entry.title,
        style: TextStyles.faqHeadingTextStyle.copyWith(
          fontSize: DeviceUtils.getScaledHeight(
            context,
            0.023,
          ),
            fontFamily: 'pSans'
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.entry.description,
            style: TextStyles.faqBodyTextStyle.copyWith(

              fontSize: DeviceUtils.getScaledHeight(
                context,
                0.022,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
