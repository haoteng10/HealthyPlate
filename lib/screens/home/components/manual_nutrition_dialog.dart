import "package:flutter/material.dart";
import 'package:nutrition/screens/login/components/form_input.dart';
import "package:nutrition/services/database.dart";
import "package:provider/provider.dart";
import "package:nutrition/models/user.dart";

class ManualNutritionDialogue extends StatefulWidget {
  @override
  _ManualNutritionDialogueState createState() => _ManualNutritionDialogueState();
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
  int _curr = 1;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    Future<void> manualAddFoodItem() async {
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
      title: Text(
        "Manual Nutrition Input",
        textAlign: TextAlign.center,
      ),
      content: Stack(
        children: <Widget>[
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
                      hintText: "Description",
                    ),
                    onChanged: (String value) {
                      _servingDescription = value;
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
                      hintText: "Serving size",
                    ),
                    onChanged: (String value) {
                      _servingAmount = value;
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Add Entry"),
          onPressed: () async {
            await manualAddFoodItem();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
