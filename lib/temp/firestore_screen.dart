import "package:flutter/material.dart";
import "package:nutrition/models/food.dart";
import 'package:nutrition/components/loading.dart';
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
        title: Text("Recorded Foods"),
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
                    elevation: 5,
                    color: Colors.lightBlue[300],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            title: Text(
                                "${(food.brandName ?? "") + " " + (food.foodName ?? "")}"),
                            subtitle:
                                Text("Calories: ${food.serving.calories}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.more_horiz,
                                    size: 20.0,
                                    color: Colors.brown[900],
                                  ),
                                  onPressed: () {
                                    //   _onDeleteItemPressed(index);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete_outline,
                                    size: 20.0,
                                    color: Colors.brown[900],
                                  ),
                                  onPressed: () {
                                    //   _onDeleteItemPressed(index);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
