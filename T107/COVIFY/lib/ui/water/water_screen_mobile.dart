import 'dart:async';

import 'package:covid19/constants/colors.dart';
import 'package:covid19/constants/dimens.dart';
import 'package:covid19/constants/strings.dart';
import 'package:covid19/constants/text_styles.dart';
import 'package:covid19/icons/covid19_icons.dart';
import 'package:covid19/utils/device/device_utils.dart';
import 'package:covid19/widgets/sized_box_height_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waveprogressbar_flutter/waveprogressbar_flutter.dart';

class WaterScreenMobile extends StatefulWidget {
  @override
  _WaterScreenMobileState createState() => _WaterScreenMobileState();
}

class _WaterScreenMobileState extends State<WaterScreenMobile> {
  double waterHeight=0.0;
  int mLitre = 2500;
  int yourDrink = 0;
  int myMl;
  WaterController waterController=WaterController();

  @override
  void initState()  {
    super.initState();
    mywater();
  }
mywater() async {
  final prefs = await SharedPreferences.getInstance();
  final yourDrink = prefs.getInt('yourDrink') ?? 0;
  setState(() {
    int ml = prefs.getInt('yourDrink') ?? 0;
    myMl = ml *250;
  });

print(yourDrink);
  WidgetsBinding widgetsBinding=WidgetsBinding.instance;
  widgetsBinding.addPostFrameCallback((callback) async {

    if(yourDrink==0){
      waterController.changeWaterHeight(0.00);
    }

    if(yourDrink==1){
      waterController.changeWaterHeight(0.10);
    }
    if(yourDrink==2){
      waterController.changeWaterHeight(0.20);
    }
    if(yourDrink==3){
      waterController.changeWaterHeight(0.30);
    }
    if(yourDrink==4){
      waterController.changeWaterHeight(0.40);
    }
    if(yourDrink==5){
      waterController.changeWaterHeight(0.50);
    }
    if(yourDrink==6){
      waterController.changeWaterHeight(0.60);
    }
    if(yourDrink==7){
      waterController.changeWaterHeight(0.70);
    }
    if(yourDrink==8){
      waterController.changeWaterHeight(0.80);
    }
    if(yourDrink==9){
      waterController.changeWaterHeight(0.90);
    }
    if(yourDrink==10){
      waterController.changeWaterHeight(1.00);
      final prefs1 = await SharedPreferences.getInstance();
      prefs1.setInt('yourDrink', -1);
      print(yourDrink);
    }

  });
}

  bool visible = true;

  buttonvisi(){
    setState(() {
      visible = false ;
    });
  }

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
                        Strings.waterTitle,
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
                   flex: 5,
                   child: Center(
                    child: WaveProgressBar(
                      flowSpeed: 1.0,
                      waveDistance:45.0,
                      waterColor: const Color(0xFF68BEFC),
                      strokeCircleColor: AppColors.accentColor,
                      heightController: waterController,
                      percentage: waterHeight,
                      size:  const Size (300,300),
                      textStyle:const TextStyle(
                          color:AppColors.primaryColor,
                          fontSize: 60.0,
                          fontWeight: FontWeight.bold),
                    ),
                ),
                 ),

              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('$myMl'+"/2500 ml",style: TextStyle(color:AppColors.accentBlackColor, fontSize: 18, fontWeight: FontWeight.w600),),
              )),

              Center(child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("1 drink is 250ml",style: TextStyle(color:AppColors.accentBlackColor, fontSize: 12),),
              )),

              Center(
                child: Visibility(
                  visible: visible,
                  child: Ink(
                      decoration: const ShapeDecoration(
                        color: AppColors.primaryColor,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          final yourDrink = prefs.getInt('yourDrink') ?? 0;
                          print(yourDrink);

                          final prefs1 = await SharedPreferences.getInstance();
                          prefs1.setInt('yourDrink', yourDrink+1);
                          print(yourDrink);
                          mywater();
                          buttonvisi();
                          Timer(Duration(seconds:3),(){
                            setState(() {
                              visible = true ;
                            });
                          });

                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        iconSize: 40.0,
                      ),
                  ),
                ),
              ),
              SizedBoxHeightWidget(screenHeight / 25),





            ],
          ),
        ),
      ),
    );
  }
}
