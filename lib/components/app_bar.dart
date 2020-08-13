import "package:flutter/material.dart";
import 'package:nutrition/screens/login_screen.dart';
import "../constants.dart";

AppBar appBar(BuildContext context, String title1, String title2) {
  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    elevation: 0,
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      iconSize: 20,
      color: Colors.blue,
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: "$title1 ",
            style: TextStyle(color: kPrimaryColor),
          ),
          TextSpan(
            text: title2,
            style: TextStyle(color: kSecondaryColor),
          ),
        ],
      ),
    ),
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: IconButton(
          icon: Icon(Icons.account_circle),
          color: Colors.blue,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              ),
            );
          },
        ),
      ),
    ],
  );
}
