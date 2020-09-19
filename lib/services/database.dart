import "package:cloud_firestore/cloud_firestore.dart";
import 'package:nutrition/models/api/serving.dart';
import "package:nutrition/models/food.dart";
import "package:nutrition/services/fatsecret.dart";

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
      "name": name,
      "foods": [],
    });
  }

  Future<void> addFood(String foodID) async {
    DateTime now = DateTime.now();
    String timeString = now.toString();

    DocumentReference addedFoodDocument = await foodsCollection.add({
      "food_id": foodID,
      "user": Firestore.instance.document("users/" + uid),
      "dateTime": timeString,
    });

    await usersCollection.document(uid).updateData({
      "foods": FieldValue.arrayUnion([addedFoodDocument]),
    });
  }

  Future<void> manualAddFood(
    String brand,
    String name,
    String calories,
    String carbohydrate,
    String fat,
    String protein,
    String servingAmount,
    String servingUnit,
    String servingDescription,
  ) async {
    Map inputFood = {
      "brandName": brand,
      "foodName": name,
      "serving": {
        "calories": calories,
        "carbohydrate": carbohydrate,
        "fat": fat,
        "protein": protein,
        "servingAmount": servingAmount,
        "servingUnit": servingUnit,
        "servingDescription": servingDescription,
      },
    };

    DateTime now = DateTime.now();
    String timeString = now.toString();
    // DateTime convertedTime = DateTime.parse(timeString);

    DocumentReference addedFoodDocument = await foodsCollection.add({
      "food": inputFood,
      "user": Firestore.instance.document("users/" + uid),
      "dateTime": timeString,
    });

    await usersCollection.document(uid).updateData({
      "foods": FieldValue.arrayUnion([addedFoodDocument]),
    });
  }

  Future<List<FoodData>> _foodDataListFromFoodCollectionSnapshot(
      QuerySnapshot snapshot) async {
    dynamic futures = snapshot.documents.map((doc) async {
      //Get the user information from the food"s user reference
      DocumentSnapshot userData = await doc.data["user"].get();
      //If the user's uid in the food document is equal to the user"s uid of the application
      //Return the food document to the StreamBuilder in an array of items
      //Returns null if the condition is not meet
      //Therefore, the returned array can be something like this: [null, null, "instance of FoodData"]
      if (userData.documentID == uid) {
        if (doc["food_id"] != null) {
          return await FatSecretService()
              .getFoodNutrition(int.parse(doc["food_id"]));
        } else {
          return FoodData(
            foodName: doc["food"]["foodName"],
            brandName: doc["food"]["brandName"],
            serving: Serving(
              calories: doc["food"]["serving"]["calories"],
              carbohydrate: doc["food"]["serving"]["carbohydrate"],
              fat: doc["food"]["serving"]["fat"],
              protein: doc["food"]["serving"]["protein"],
              servingAmount: doc["food"]["serving"]["servingAmount"],
              servingDescription: doc["food"]["serving"]["servingDescription"],
              servingUnit: doc["food"]["serving"]["servingUnit"],
            ),
          );
        }
      }
    });

    return await Future.wait(futures);
  }

  Future<List<Food>> _foodListFromFoodCollectionSnapshot(
      QuerySnapshot snapshot) async {
    dynamic futures = snapshot.documents.map((doc) async {
      //Get the user information from the food"s user reference
      DocumentSnapshot userData = await doc.data["user"].get();
      //If the user's uid in the food document is equal to the user"s uid of the application
      //Return the food document to the StreamBuilder in an array of items
      //Returns null if the condition is not meet
      //Therefore, the returned array can be something like this: [null, null, "instance of FoodData"]
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
