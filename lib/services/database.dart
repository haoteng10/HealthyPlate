import "package:cloud_firestore/cloud_firestore.dart";

class DatabaseService {
  final CollectionReference foodsCollection =
      Firestore.instance.collection("foods");
}
