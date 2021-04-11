import "package:flutter/material.dart";
import "package:nutrition/models/food.dart";
import 'package:nutrition/components/loading.dart';
import "package:nutrition/services/database.dart";
import "package:nutrition/models/user.dart";
import "package:provider/provider.dart";

class ListFoodsScreen extends StatefulWidget {
  @override
  _ListFoodsScreenState createState() => _ListFoodsScreenState();
}

class _ListFoodsScreenState extends State<ListFoodsScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        title: Text("Recorded Foods"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<FoodData>>(
        stream: DatabaseService(uid: user.uid).foodData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<FoodData> foods = snapshot.data;

            if (foods.every((element) => element == null)) {
              return Container(
                child: Center(
                  child: Image.asset(
                    "assets/images/nodata.png",
                    height: size.height * 0.35,
                  ),
                ),
              );
            } else {
              return ListView(
                children: foods.map((FoodData food) {
                  if (food != null) {
                    return Card(
                      elevation: 5,
                      color: Color.fromRGBO(13, 91, 242, 1),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                "${(food.brandName ?? "") + " " + (food.foodName ?? "")}",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                "Calories: ${food.serving.calories}",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.more_horiz,
                                      size: 20.0,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      showModalBottomSheet<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ListFoodBottomSheet(
                                              inputFood: food,
                                            );
                                          });
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete_outline,
                                      size: 20.0,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      //Do something
                                      await DatabaseService(uid: user.uid).deleteFoodDocument(food.documentID);
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
            }
          } else {
            return LoadingScreen();
          }
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class ListFoodBottomSheet extends StatelessWidget {
  FoodData inputFood;
  ListFoodBottomSheet({this.inputFood});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 3,
                child: Text(
                  "${(inputFood.brandName ?? "") + " " + (inputFood.foodName ?? "")}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 24.0,
                  ),
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Calories ",
                      style: TextStyle(
                        color: Color.fromRGBO(242, 164, 13, 1),
                        fontSize: 38.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      inputFood.serving.calories,
                      style: TextStyle(
                        color: Color.fromRGBO(31, 224, 44, 1),
                        fontSize: 38.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Carbohydrate",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      inputFood.serving.carbohydrate + " g",
                      style: TextStyle(
                        color: Color.fromRGBO(31, 224, 44, 1),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Fat",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      inputFood.serving.fat + " g",
                      style: TextStyle(
                        color: Color.fromRGBO(31, 224, 44, 1),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Protein",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      inputFood.serving.protein + " g",
                      style: TextStyle(
                        color: Color.fromRGBO(31, 224, 44, 1),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Serving Size",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      inputFood.serving.servingAmount + " g" ?? "",
                      style: TextStyle(
                        color: Color.fromRGBO(31, 224, 44, 1),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Serving Description",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      inputFood.serving.servingDescription ?? "",
                      style: TextStyle(
                        color: Color.fromRGBO(31, 224, 44, 1),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
