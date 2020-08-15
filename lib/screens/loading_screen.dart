import "package:flutter/material.dart";
import 'package:nutrition/components/loading.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[300],
      body: Center(
        child: Loading(),
      ),
    );
  }
}
