import "package:cloud_firestore/cloud_firestore.dart";
import "package:nutrition/models/food.dart";

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference foodsCollection =
      Firestore.instance.collection("foods");
  final CollectionReference usersCollection =
      Firestore.instance.collection("users");

  Future<void> createUser(String name) async {
    await usersCollection.document(uid).setData({
      "uid": uid,
    });
  }

  List<Food> _foodListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((doc) =>
            Food(name: doc.data["name"], calories: doc.data["calories"]))
        .toList();
  }

  //Get Foods stream
  Stream<List<Food>> get foods {
    return foodsCollection.snapshots().map(_foodListFromSnapshot);
  }
}
