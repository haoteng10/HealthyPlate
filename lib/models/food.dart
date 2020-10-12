import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrition/models/api/serving.dart';

class Food {
  final String foodID;
  final DocumentReference user;

  Food({
    this.foodID,
    this.user,
  });
}

class FoodData {
  final String brandName;
  final String foodName;
  final String foodUrl;
  final Serving serving;

  final DocumentReference user;

  final String dateTime;

  final String documentID;

  FoodData({
    this.brandName,
    this.foodName,
    this.foodUrl,
    this.serving,
    this.user,
    this.dateTime,
    this.documentID,
  });
}
