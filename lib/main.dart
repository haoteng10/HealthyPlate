import "package:flutter/material.dart";
import "package:nutrition/constants.dart";
import 'package:nutrition/wrapper.dart';
import 'package:nutrition/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:nutrition/models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Nutrition App",
          theme: ThemeData(
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.white,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: Theme.of(context).textTheme.apply(
                    displayColor: kBlackColor,
                  )),
          home: Wrapper()),
    );
  }
}
