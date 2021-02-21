import 'package:covid19/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';


class MapScreenMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LIVE HEAT MAP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primaryColor: Colors.white,
      ),
      home: MapPage(),
    );
  }
}



class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  WebViewController _controller;
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: 'https://www.trackcorona.live/map',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
//              loadEmbeddedCode();
            },
            onPageStarted: (url) {
              setState(() {
                isLoading = true;
              });
            },
            onPageFinished: (url) {
              removeAds(url);
              setState(() {
                isLoading = false;
              });
            },
          ),
          if (isLoading) Center(
              child: Container(
              height: MediaQuery.of(context).size.height,
              width:MediaQuery.of(context).size.width,
              color: themeData.primaryColor,
                  child: const Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                      ),
                    ),

                  )

              )

          ) else Container(),
        ],
      ),
    );
  }

  String getEmbeddedCode() {
    return '<!DOCTYPE html> <html> <head><title>Page Title</title> <style>body {background-color: white;text-align: center;color: white;font-family: Arial, Helvetica, sans-serif;}</style></head> <body> <p><a href="https://commons.wikimedia.org/wiki/File:COVID-19_Outbreak_World_Map_per_Capita.svg#/media/File:COVID-19_Outbreak_World_Map_per_Capita.svg"><img style="width:4600px;height:2000px;" src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/COVID-19_Outbreak_World_Map_per_Capita.svg/1200px-COVID-19_Outbreak_World_Map_per_Capita.svg.png" alt="COVID-19 Outbreak World Map per Capita.svg"></a></p></body></html>';
  }

  void removeAds(String url){
    print("remove");
    _controller.evaluateJavascript("document.getElementsByClassName('navbar-brand').style.display='none';");
    _controller.evaluateJavascript("document.getElementsByClassName('navbar-nav ml-auto').style.display='none';");
    _controller.evaluateJavascript("document.getElementById('changeMode').style.display='none';");
    _controller.evaluateJavascript("document.getElementById('openLegend').style.display='none';");
    _controller.evaluateJavascript("document.getElementsByClassName('sidebar-header').style.display='none';");
    _controller.evaluateJavascript("document.getElementById('entirenavbar').style.display='none';");
    _controller.evaluateJavascript("document.getElementsByClassName('sidebar-header').style.display='none';");
    _controller.evaluateJavascript("document.getElementById('refineSliderContainer').style.display='none';");

  }

  void loadEmbeddedCode() {
    _controller.loadUrl(Uri.dataFromString(getEmbeddedCode(),
        mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
