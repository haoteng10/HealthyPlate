import 'package:flutter/material.dart';
import 'package:nutrition/screens/authenticate_screen.dart';
import 'package:nutrition/screens/home_screen.dart';
import 'package:nutrition/models/user.dart';
import 'package:provider/provider.dart';

//Returns either Home page or Sign In page
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    //Return either home screen or authenticate screen
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
