import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:nutrition/models/food.dart';
import 'package:nutrition/screens/loading_screen.dart';
import 'package:nutrition/services/database.dart';
import 'package:nutrition/models/user.dart';
import 'package:provider/provider.dart';

class FirestoreDebug extends StatefulWidget {
  @override
  _FirestoreDebugState createState() => _FirestoreDebugState();
}

class _FirestoreDebugState extends State<FirestoreDebug> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Firestore Page"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Food>>(
        stream: DatabaseService(uid: user.uid).foods,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Food> foods = snapshot.data;
            return ListView(
              children: foods.map((dynamic food) {
                // If the snapshot array is NOT null, return the card. If it is null, then return an empty container.
                if (food != null) {
                  return Card(
                    child: ListTile(
                      title: Text("Name: ${food.name}"),
                      subtitle: Text("Calories: ${food.calories}"),
                    ),
                  );
                } else {
                  return Container();
                }
              }).toList(),
            );
          } else {
            return LoadingScreen();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Firestore.instance.collection("foods").add({
            "name": "pear",
            "calories": 20,
            "user": Firestore.instance.document("users/" + user.uid),
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
