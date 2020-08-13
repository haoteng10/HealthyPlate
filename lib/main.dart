import "package:flutter/material.dart";
import "package:nutrition/constants.dart";
import 'package:nutrition/screens/loading_screen.dart';
import 'package:nutrition/screens/home_screen.dart';
import 'package:nutrition/screens/test_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Nutrition App",
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: Theme.of(context).textTheme.apply(
                displayColor: kBlackColor,
              )),
      initialRoute: "/home",
      routes: {
        "/": (context) => Loading(),
        "/home": (context) => Home(),
        "/debug": (context) => Debug()
      },
    );
  }
}
