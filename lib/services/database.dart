import "package:cloud_firestore/cloud_firestore.dart";
import 'package:nutrition/models/api/serving.dart';
import "package:nutrition/models/food.dart";
import "package:nutrition/services/fatsecret.dart";
import "dart:async";
import "dart:core";

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

  Future<void> deleteFoodDocument(String documentID) async {
    DocumentReference foodDoc = foodsCollection.document(documentID);
    print(foodDoc);

    await usersCollection.document(uid).updateData({
      "foods": FieldValue.arrayRemove([foodDoc]),
    });

    await foodDoc.delete();
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
          return await FatSecretService().getFoodNutrition(
              int.parse(doc["food_id"]), doc["dateTime"], doc.documentID);
        } else {
          return FoodData(
            foodName: doc["food"]["foodName"],
            brandName: doc["food"]["brandName"],
            dateTime: doc["dateTime"],
            documentID: doc.documentID,
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

  // ignore: unused_element
  // Future<List<FoodData>> _foodDataListFromUserCollectionSnapshot(
  //     QuerySnapshot snapshot) async {
  //   List<FoodData> completedFoodList = [];

  //   snapshot.documents.forEach((doc) async {
  //     List<dynamic> foods = doc.data["foods"];

  //     foods.forEach((food) async {
  //       DocumentSnapshot actualFood = await food.get();
  //       print(actualFood.data["food"]);
  //       if (actualFood.data["food_id"] == null) {
  //         completedFoodList.add(FoodData(
  //           foodName: actualFood.data["food"]["foodName"],
  //           brandName: actualFood.data["food"]["brandName"],
  //           serving: Serving(
  //             calories: actualFood.data["food"]["serving"]["calories"],
  //             carbohydrate: actualFood.data["food"]["serving"]["carbohydrate"],
  //             fat: actualFood.data["food"]["serving"]["fat"],
  //             protein: actualFood.data["food"]["serving"]["protein"],
  //             servingAmount: actualFood.data["food"]["serving"]
  //                 ["servingAmount"],
  //             servingDescription: actualFood.data["food"]["serving"]
  //                 ["servingDescription"],
  //             servingUnit: actualFood.data["food"]["serving"]["servingUnit"],
  //           ),
  //         ));
  //       } else {
  //         completedFoodList.add(await FatSecretService()
  //             .getFoodNutrition(int.parse(actualFood.data["food_id"])));
  //       }
  //     });
  //   });

  //   // print(await Future.wait(futures));
  //   return completedFoodList;
  // }

  Future<List<Food>> _foodListFromFoodCollectionSnapshot(
      QuerySnapshot snapshot) async {
    dynamic futures = snapshot.documents.map((doc) async {
      DocumentSnapshot userData = await doc.data["user"].get();
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
    // return usersCollection
    //     .snapshots()
    //     .asyncMap(_foodDataListFromUserCollectionSnapshot);
  }
}
