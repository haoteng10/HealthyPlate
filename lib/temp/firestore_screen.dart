import "package:flutter/material.dart";
import "package:nutrition/models/food.dart";
import "package:nutrition/screens/loading_screen.dart";
import "package:nutrition/services/database.dart";
import "package:nutrition/models/user.dart";
import "package:provider/provider.dart";

class FirestoreDebug extends StatefulWidget {
  @override
  _FirestoreDebugState createState() => _FirestoreDebugState();
}

class _FirestoreDebugState extends State<FirestoreDebug> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Firestore Page"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<FoodData>>(
        stream: DatabaseService(uid: user.uid).foodData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<FoodData> foods = snapshot.data;
            return ListView(
              children: foods.map((FoodData food) {
                // If the snapshot array is NOT null, return the card. If it is null, then return an empty container.
                if (food != null) {
                  return Card(
                    child: ListTile(
                      title:
                          Text("Name: ${food.brandName + " " + food.foodName}"),
                      subtitle: Text("URL: ${food.foodUrl}"),
                    ),
                  );
                } else {
                  return Container();
                }
              }).toList(),
            );
          } else {
            return LoadingScreen();
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showModalBottomSheet(
      //         context: context, builder: (context) => AddItemBottomSheet());
      //     // DatabaseService(uid: user.uid).addFood("apple", 50);
      //   },
      //   child: Icon(Icons.add),
      //   backgroundColor: Colors.pink,
      // ),
    );
  }
}
