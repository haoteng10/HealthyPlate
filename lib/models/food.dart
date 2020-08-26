import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  final String name;
  final int calories;
  final DocumentReference user;

  Food({this.name, this.calories, this.user});
}
