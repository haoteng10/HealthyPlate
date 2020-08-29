import "package:flutter/material.dart";
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
          showModalBottomSheet(
              context: context, builder: (context) => AddItemBottomSheet());
          // DatabaseService(uid: user.uid).addFood("apple", 50);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}

class AddItemBottomSheet extends StatefulWidget {
  @override
  _AddItemBottomSheetState createState() => _AddItemBottomSheetState();
}

class _AddItemBottomSheetState extends State<AddItemBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  // Items
  String _name;
  int _calories;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Name",
                ),
                onChanged: (String value) {
                  setState(() {
                    _name = value;
                  });
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please enter some text.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Calories",
                ),
                onChanged: (String value) {
                  setState(() {
                    _calories = int.parse(value);
                  });
                },
                validator: (String value) {
                  int noVal;
                  try {
                    noVal = int.parse(value);
                  } catch (err) {
                    return "Invalid Input: Please enter a positive integer.";
                  }
                  if (noVal < 0) {
                    return "Invalid Input: Please enter a positive integer.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              RaisedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      //Add to database
                      DatabaseService(uid: user.uid).addFood(_name, _calories);
                      //Exit the bottom sheet
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(Icons.add_to_queue),
                  label: Text("Add")),
            ],
          )),
    );
  }
}
