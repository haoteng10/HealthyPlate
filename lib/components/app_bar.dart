import "package:flutter/material.dart";
import "package:nutrition/screens/login/login_screen.dart";
import "../constants.dart";

AppBar appBar(BuildContext context, String title,) {
  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    elevation: 0,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios),
      iconSize: 20,
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: title,
            style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 18),
          ),
        ],
      ),
    ),
  );
}
