import 'package:flutter/material.dart';
import 'package:YesHealthy/pages/loading.dart';
import 'package:YesHealthy/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YesHealthy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/home",
      routes: {"/": (context) => Loading(), "/home": (context) => Home()},
    );
  }
}
