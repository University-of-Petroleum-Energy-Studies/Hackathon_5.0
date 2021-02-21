import 'dart:convert';
import 'package:covid19/constants/colors.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './detailspage.dart';


class NewsScreenMobile extends StatefulWidget {
  @override
  _NewsScreenMobileState createState() => _NewsScreenMobileState();
}

class _NewsScreenMobileState extends State<NewsScreenMobile> {
  List data;

  @override
  void initState() {
    super.initState();
    fetch_data_from_api();
  }

  Future<String> fetch_data_from_api() async {
    var jsondata = await http.get(
        "https://newsapi.org/v2/everything?apiKey=33ba1edf12644aafab6ae0d075c4d496&q=covid&from=2021-01-20&language=en");
    var fetchdata = jsonDecode(jsondata.body);
    setState(() {
      data = fetchdata["articles"];
    });
    return "Success";
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: Scaffold(
            body: data!=null
                ?
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [AppColors.eggA, AppColors.eggB])),

              child: Padding(
                padding: EdgeInsets.only(top: 100.0),
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        hoverColor:Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                  author: data[index]["author"],
                                  title: data[index]["title"],
                                  description: data[index]["description"],
                                  urlToImage: data[index]["urlToImage"],
                                  publishedAt: data[index]["publishedAt"],
                                )));
                      },
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                              ),
                              child: Image.network(
                                data[index]["urlToImage"],
                                fit: BoxFit.cover,
                                height: 400.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 350.0, 0.0, 0.0),
                            child: Container(

                              height: 250.0,
                              width: 400.0,
                              child: Card(

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(45.0),
                                ),
                                elevation: 15.0,

                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(45),
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [AppColors.whiteColor.withOpacity(0.2), AppColors.whiteColor.withOpacity(0.2)])),
                                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            20.0, 20.0, 10.0, 20.0),
                                        child: Text(
                                          data[index]["title"],
                                          style: TextStyle(
                                            color: AppColors.blackColor.withOpacity(0.8),
                                            fontSize: 25.0,
                                            fontFamily: 'pSans',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: data == null ? 0 : data.length,
                  viewportFraction: 0.8,
                  scale: 0.9,
                  autoplay: true,
                  loop: true,
                  autoplayDelay: 4000,

                ),
              ),
            )
        :Center(
    child: CircularProgressIndicator(),
        )
        )
    );
  }
}