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
      "uid": uid, //Will be removed in the future
      "name": name,
      "foods": [],
    });
  }

  Future<void> addFood(String name, int calories) async {
    await foodsCollection.add({
      "name": name,
      "calories": calories,
      "user": Firestore.instance.document("users/" + uid),
    });
  }

  Future<List<Food>> _foodListFromFoodCollectionSnapshot(
      QuerySnapshot snapshot) async {
    dynamic futures = snapshot.documents.map((doc) async {
      //Get the user information from the food's user reference
      DocumentSnapshot userData = await doc.data["user"].get();
      //If the user's uid in the food document is equal to the user's uid of the application
      //Return the food document to the StreamBuilder in an array of items
      //Returns null if the condition is not meet
      //Therefore, the returned array can be something like this: [null, null, "instance of Food"]
      if (userData.data["uid"] == uid) {
        return Food(
          name: doc.data["name"],
          calories: doc.data["calories"],
          user: doc.data["user"],
        );
      }
    });
    return await Future.wait(futures);
  }

  //Get Foods stream
  Stream<List<Food>> get foods {
    return foodsCollection
        .snapshots()
        .asyncMap(_foodListFromFoodCollectionSnapshot);
  }
}
