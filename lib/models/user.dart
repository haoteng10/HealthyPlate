import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  User({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final List<DocumentReference> foods;

  UserData({this.uid, this.name, this.foods});
}
