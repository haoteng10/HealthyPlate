import "package:cloud_firestore/cloud_firestore.dart";
import "package:nutrition/models/food.dart";
import 'package:nutrition/services/fatsecret.dart';

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

  Future<void> addFood(String foodID) async {
    DocumentReference addedFoodDocument = await foodsCollection.add({
      "food_id": foodID,
      "user": Firestore.instance.document("users/" + uid),
    });

    await usersCollection.document(uid).updateData({
      "foods": FieldValue.arrayUnion([addedFoodDocument]),
    });
  }

  Future<List<FoodData>> _foodDataListFromFoodCollectionSnapshot(
      QuerySnapshot snapshot) async {
    dynamic futures = snapshot.documents.map((doc) async {
      //Get the user information from the food's user reference
      DocumentSnapshot userData = await doc.data["user"].get();
      //If the user's uid in the food document is equal to the user's uid of the application
      //Return the food document to the StreamBuilder in an array of items
      //Returns null if the condition is not meet
      //Therefore, the returned array can be something like this: [null, null, "instance of Food"]
      if (userData.data["uid"] == uid) {
        return await FatSecretService()
            .getFoodNutrition(int.parse(doc["food_id"]));
      }
    });
    return await Future.wait(futures);
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
          foodID: doc.data["food_id"],
          user: doc.data["user"],
        );
      }
    });
    return await Future.wait(futures);
  }

  // Get Foods stream
  Stream<List<Food>> get foods {
    return foodsCollection
        .snapshots()
        .asyncMap(_foodListFromFoodCollectionSnapshot);
  }

  //Get FoodData stream
  Stream<List<FoodData>> get foodData {
    return foodsCollection
        .snapshots()
        .asyncMap(_foodDataListFromFoodCollectionSnapshot);
  }
}
