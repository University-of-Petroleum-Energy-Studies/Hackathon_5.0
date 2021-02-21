import 'package:carousel_slider/carousel_slider.dart';
import 'package:covid19/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:covid19/ui/travelguidelines/destinations.dart';

import 'package:expansion_tile_card/expansion_tile_card.dart';
class TravelMobileScreen extends StatefulWidget {
  @override
  _TravelMobileScreenState createState() => _TravelMobileScreenState();
}

class _TravelMobileScreenState extends State<TravelMobileScreen> {
  int _index = 0;
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [AppColors.eggC, AppColors.eggD])),

          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[

              CarouselSlider(items: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(

                    width: 450,
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                      image: AssetImage('assets/images/asia.jpg'),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("ASIA",
                      style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontSize: 32, fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ExpansionTileCard(
                            baseColor: Color.fromRGBO(255, 255, 255, 0.8),
                              title: Text("India",style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 24),),
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,

                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text("Travelers at increased risk for severe illness from COVID-19 should avoid all nonessential travel to India. Before you travel, get tested with a viral test 1–3 days before your trip. During travel, wear a mask, avoid crowds, stay at least 6 feet from people who are not traveling with you, wash your hands often or use hand sanitizer, and watch for symptoms. After you travel, get tested 3–5 days after travel AND stay home to self-quarantine for 7 days after travel. If you don't get tested, it's safest to stay home to self-quarantine for 10 days.  ",style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(fontSize: 16),),
                                ),
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ExpansionTileCard(
                            baseColor: Color.fromRGBO(255, 255, 255, 0.8),
                            title: Text("China",style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(fontSize: 24),),
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,

                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text("Travel may increase your chance of getting and spreading COVID-19. Talk to your doctor ahead of travel, especially if you are at increased risk for severe illness from COVID-19. If you are eligible, get fully vaccinated for COVID-19. Wait 2 weeks after getting your second vaccine dose to travel—it takes time for your body to build protection after any vaccination. Do NOT travel if you were exposed to COVID-19, you are sick, or you test positive for COVID-19. If traveling by air, check if your airline requires any health information, test results, or other documents. Check with your destination's Office of Foreign Affairs or Ministry of Health.",style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(fontSize: 16),),
                                ),
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ExpansionTileCard(
                            baseColor: Color.fromRGBO(255, 255, 255, 0.8),
                            title: Text("Japan",style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(fontSize: 24),),
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,

                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text("Travelers should avoid all travel to Japan. Travel may increase your chance of getting and spreading COVID-19. Before you travel, get tested with a viral test 1-3 days before your trip. Do not travel if you are waiting for test results, test positive, or are sick. Follow all entry requirements for your destination and provide any required or requested health information. During travel, wear a mask, stay at least 6 feet away from people who are not traveling with you, wash your hands often or use hand sanitizer, and watch your health for signs of illness.",style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(fontSize: 16),),
                                ),
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ExpansionTileCard(
                            baseColor: Color.fromRGBO(255, 255, 255, 0.8),
                            title: Text("Russia",style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(fontSize: 24),),
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,

                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text("Travelers should avoid all travel to Russia. Travel may increase your chance of getting and spreading COVID-19. Before you travel, get tested with a viral test 1-3 days before your trip. Do not travel if you are waiting for test results, test positive, or are sick. Follow all entry requirements for your destination and provide any required or requested health information. During travel, wear a mask, stay at least 6 feet away from people who are not traveling with you, wash your hands often or use hand sanitizer, and watch your health for signs of illness. After you travel, continue to take steps to prevent others from getting sick. Wear a mask when outside your home, stay at least 6 feet away from people who are not in your household, wash your hands often or use hand sanitizer, and watch your health for signs of illness.",style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(fontSize: 16),),
                                ),
                              )
                            ],
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ExpansionTileCard(
                            baseColor: Color.fromRGBO(255, 255, 255, 0.8),
                            title: Text("Kyrgyzstan",style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(fontSize: 24),),
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,

                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text("Travelers with increased risk for severe illness from COVID-19 should avoid all nonessential travel to Kyrgyzstan. Travel may increase your chance of getting and spreading COVID-19. Before you travel, get tested with a viral test 1-3 days before your trip. Do not travel if you are waiting for test results, test positive, or are sick. Follow all entry requirements for your destination and provide any required or requested health information. If you don't get tested, it's safest to stay home for 14 days.",style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(fontSize: 16),),
                                ),
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ExpansionTileCard(
                            baseColor: Color.fromRGBO(255, 255, 255, 0.8),
                            title: Text("Thailand",style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(fontSize: 24),),
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,

                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text("Travelers with increased risk for severe illness from COVID-19 should avoid all nonessential travel to Thailand. Travel may increase your chance of getting and spreading COVID-19. During travel, wear a mask, stay at least 6 feet away from people who are not traveling with you, wash your hands often or use hand sanitizer, and watch your health for signs of illness.",style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(fontSize: 16),),
                                ),
                              )
                            ],
                          ),
                        ),

                      ],

                    ),
                  ),

              ),
                ),



                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 350,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                        image: AssetImage('assets/images/middleeast.jpg'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("MIDDLE EAST",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 32, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTileCard(
                              baseColor: Color.fromRGBO(255, 255, 255, 0.8),
                              title: Text("Oman",style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 24),),
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,

                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text("Travelers should avoid all nonessential travel to Oman. If you must travel: Before you travel, get tested with a viral test 1-3 days before your trip. Do not travel if you are waiting for test results, test positive, or are sick. Follow all entry requirements for your destination and provide any required or requested health information. During travel, wear a mask, stay at least 6 feet away from people who are not traveling with you, wash your hands often or use hand sanitizer, and watch your health for signs of illness.",style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(fontSize: 16),),
                                  ),
                                )
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTileCard(
                              baseColor: Color.fromRGBO(255, 255, 255, 0.8),
                              title: Text("United Arab Emirates",style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 24),),
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,

                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text("Travelers should avoid all travel to United Arab Emirates. Travel may increase your chance of getting and spreading COVID-19. During travel, wear a mask, stay at least 6 feet away from people who are not traveling with you, wash your hands often or use hand sanitizer, and watch your health for signs of illness. After you travel, continue to take steps to prevent others from getting sick. Wear a mask when outside your home, stay at least 6 feet away from people who are not in your household, wash your hands often or use hand sanitizer, and watch your health for signs of illness.",style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(fontSize: 16),),
                                  ),
                                )
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTileCard(
                              baseColor: Color.fromRGBO(255, 255, 255, 0.8),
                              title: Text("Saudi Arabia",style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 24),),
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,

                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text("All flights to Saudi are cancelled",style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(fontSize: 16),),
                                  ),
                                )
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTileCard(
                              baseColor: Color.fromRGBO(255, 255, 255, 0.8),
                              title: Text("Qatar",style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 24),),
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,

                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text("All flights to Qatar are cancelled",style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(fontSize: 16),),
                                  ),
                                )
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTileCard(
                              baseColor: Color.fromRGBO(255, 255, 255, 0.8),
                              title: Text("Kuwait",style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 24),),
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,

                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text("Travelers should avoid all travel to Kuwait. Travel may increase your chance of getting and spreading COVID-19. Before you travel, get tested with a viral test 1-3 days before your trip. Do not travel if you are waiting for test results, test positive, or are sick. Follow all entry requirements for your destination and provide any required or requested health information.",style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(fontSize: 16),),
                                  ),
                                )
                              ],
                            ),
                          ),

                        ],

                      ),
                    ),

                  ),
                ),



                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 350,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                        image: AssetImage('assets/images/europe.jpg'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("EUROPE",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 32, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTileCard(
                              baseColor: Color.fromRGBO(255, 255, 255, 0.8),
                              title: Text("England",style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 24),),
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,

                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text("All flights to England are cancelled",style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(fontSize: 16),),
                                  ),
                                )
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTileCard(
                              baseColor: Color.fromRGBO(255, 255, 255, 0.8),
                              title: Text("Spain",style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 24),),
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,

                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text("All flights to Spain are cancelled",style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(fontSize: 16),),
                                  ),
                                )
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTileCard(
                              baseColor: Color.fromRGBO(255, 255, 255, 0.8),
                              title: Text("France",style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 24),),
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,

                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text("Travelers should avoid all travel to France. During travel, wear a mask, stay at least 6 feet away from people who are not traveling with you, wash your hands often or use hand sanitizer, and watch your health for signs of illness. Before traveling back, get tested with a viral test 1-3 days before travel. Follow all destination and airline recommendations or requirements.",style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(fontSize: 16),),
                                  ),
                                )
                              ],
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTileCard(
                              baseColor: Color.fromRGBO(255, 255, 255, 0.8),
                              title: Text("Germany",style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 24),),
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,

                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text("Travelers should avoid all travel to Germany. Travel may increase your chance of getting and spreading COVID-19.",style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(fontSize: 16),),
                                  ),
                                )
                              ],
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTileCard(
                              baseColor: Color.fromRGBO(255, 255, 255, 0.8),
                              title: Text("Italy",style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 24),),
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,

                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text("Before you travel, get tested with a viral test 1-3 days before your trip. Do not travel if you are waiting for test results, test positive, or are sick. Follow all entry requirements for your destination and provide any required or requested health information.",style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(fontSize: 16),),
                                  ),
                                )
                              ],
                            ),
                          ),

                        ],

                      ),
                    ),

                  ),
                ),



                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 350,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                        image: AssetImage('assets/images/northamerica.jpg'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("NORTH & SOUTH AMERICA",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 32, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTileCard(
                              baseColor: Color.fromRGBO(255, 255, 255, 0.8),
                              title: Text("United States of America",style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 24),),
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,

                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text("COVID-19 risk is high in the United States. Stay at least 6 feet (about 2 arms' length) from anyone who is not from your household. It is important to do this everywhere -- both indoors and outdoors. Wear a mask to keep your nose and mouth covered when you are outside of your home. Wash your hands often or use hand sanitizer (with at least 60% alcohol).",style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(fontSize: 16),),
                                  ),
                                )
                              ],
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTileCard(
                              baseColor: Color.fromRGBO(255, 255, 255, 0.8),
                              title: Text("Canada",style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 24),),
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,

                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text("Travelers should avoid all travel to Canada. Travel may increase your chance of getting and spreading COVID-19.",style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(fontSize: 16),),
                                  ),
                                )
                              ],
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTileCard(
                              baseColor: Color.fromRGBO(255, 255, 255, 0.8),
                              title: Text("Mexico",style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 24),),
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,

                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text("Before you travel, get tested with a viral test 1-3 days before your trip. Do not travel if you are waiting for test results, test positive, or are sick. Follow all entry requirements for your destination and provide any required or requested health information. During travel, wear a mask, stay at least 6 feet away from people who are not traveling with you, wash your hands often or use hand sanitizer, and watch your health for signs of illness.",style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(fontSize: 16),),
                                  ),
                                )
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTileCard(
                              baseColor: Color.fromRGBO(255, 255, 255, 0.8),
                              title: Text("Brazil",style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 24),),
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,

                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text("Travelers should avoid all travel to Brazil. Travel may increase your chance of getting and spreading COVID-19. Wear a mask when outside your home, stay at least 6 feet away from people who are not in your household, wash your hands often or use hand sanitizer, and watch your health for signs of illness.",style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(fontSize: 16),),
                                  ),
                                )
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTileCard(
                              baseColor: Color.fromRGBO(255, 255, 255, 0.8),
                              title: Text("Argentina",style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 24),),
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,

                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text("Do not travel if you are waiting for test results, test positive, or are sick. Follow all entry requirements for your destination and provide any required or requested health information.",style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(fontSize: 16),),
                                  ),
                                )
                              ],
                            ),
                          ),

                        ],

                      ),
                    ),

                  ),
                ),


              ]
                  , options: CarouselOptions(
                    height: 650,
                    aspectRatio: 2/3,
                    viewportFraction: 0.9,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  )
              )
            ]


          ),
        ),
      );
  }
}
