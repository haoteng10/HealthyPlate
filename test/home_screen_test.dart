import "package:flutter/material.dart";
import 'package:nutrition/components/app_bar.dart';

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final Map<String, String> arguments = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: appBar(context),
      body: Text("Placeholder"),
    );
  }
}
