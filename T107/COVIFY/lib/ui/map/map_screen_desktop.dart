/*
import 'package:covid19/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'dart:html';
import 'dart:ui' as ui;

class IframeView extends StatefulWidget {
  String url;

  IframeView(this.url);

  @override
  _IframeViewState createState() => _IframeViewState();
}

class _IframeViewState extends State<IframeView> {
  final IFrameElement _iframeElement = IFrameElement();

  Widget _iframeWidget;


  @override
  void initState() {
    _iframeElement.src = widget.url;
    _iframeElement.style.border = 'none';

    ui.platformViewRegistry.registerViewFactory('iframeElement', (int viewId) {
      return _iframeElement;
    });

    _iframeWidget = HtmlElementView(
      key: UniqueKey(),
      viewType: 'iframeElement',
    );

    super.initState();
      setState(() {});

  }

  @override
  void didUpdateWidget(IframeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _iframeElement.src = widget.url;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _iframeWidget,
    );
  }
}

class MapScreenDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LIVE HEAT MAP',
      theme: ThemeData(
        primaryColor: themeData.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MapPage(title: 'LIVE HEAT MAP'),
    );
  }
}

class MapPage extends StatefulWidget {
  MapPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  int _counter = 0;
  String url = "https://www.trackcorona.live/map";
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: IframeView(url),
            ),

          ],
        ),
      ),
    );
  }
}

*/
