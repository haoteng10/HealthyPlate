import 'package:flutter/material.dart';
import 'package:nutrition/components/login.dart';
import 'package:nutrition/components/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool giveSignIn = true;
  void toggleScreen() {
    setState(() {
      giveSignIn = !giveSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (giveSignIn) {
      return Login(toggleScreen: toggleScreen);
    } else {
      return Register(toggleScreen: toggleScreen);
    }
  }
}
