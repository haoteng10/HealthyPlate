import "package:flutter/material.dart";
import 'package:nutrition/services/database.dart';
import 'package:provider/provider.dart';
import 'package:nutrition/models/user.dart';

class ManualNutritionDialogue extends StatefulWidget {
  @override
  _ManualNutritionDialogueState createState() =>
      _ManualNutritionDialogueState();
}

class _ManualNutritionDialogueState extends State<ManualNutritionDialogue> {
  // Food
  String _brand;
  String _name;
  // Serving
  String _calories;
  String _carbohydrate;
  String _fat;
  String _protein;

  String _servingAmount;
  String _servingUnit;
  String _servingDescription;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    Future<void> manualAddFoodItem() async {
      print("Food added!");
      DatabaseService(uid: user.uid).manualAddFood(
        _brand,
        _name,
        _calories,
        _carbohydrate,
        _fat,
        _protein,
        _servingAmount,
        _servingUnit,
        _servingDescription,
      );
    }

    return AlertDialog(
      title: Text("Manual Nutrition Input"),
      content: Stack(children: <Widget>[
        SingleChildScrollView(
          child: Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Brand",
                  ),
                  onChanged: (String value) {
                    _brand = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Name",
                  ),
                  onChanged: (String value) {
                    _name = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Calories",
                  ),
                  onChanged: (String value) {
                    _calories = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Carbohydrate (g)",
                  ),
                  onChanged: (String value) {
                    _carbohydrate = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Fat (g)",
                  ),
                  onChanged: (String value) {
                    _fat = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Protein (g)",
                  ),
                  onChanged: (String value) {
                    _protein = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Serving Size (Metric)",
                  ),
                  onChanged: (String value) {
                    _servingAmount = value;
                  },
                ),
                // Serving Unit
                DropdownButton<String>(
                  value: _servingUnit,
                  onChanged: (String newValue) {
                    setState(() {
                      _servingUnit = newValue;
                    });
                  },
                  items: <String>["g"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                //Serving Description
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Serving Description",
                  ),
                  onChanged: (String value) {
                    _servingDescription = value;
                  },
                ),
              ],
            ),
          ),
        ),
      ]),
      actions: <Widget>[
        FlatButton(
          child: Text('Add'),
          onPressed: () async {
            await manualAddFoodItem();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
