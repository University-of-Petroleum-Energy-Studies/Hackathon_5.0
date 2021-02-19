import 'package:hackathon/screens/loginpage.dart';
import 'package:flutter/material.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Brand-Regular',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: LoginPage.id, 
      routes: {
        LoginPage.id: (context) => LoginPage(),
      },
      darkTheme: ThemeData.dark(),
    );
  }
}
