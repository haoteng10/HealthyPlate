import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue[800],
          title: Text("YesHealthy"),
          centerTitle: true,
          elevation: 0),
      body: Text("This is the body!"),
    );
  }
}
