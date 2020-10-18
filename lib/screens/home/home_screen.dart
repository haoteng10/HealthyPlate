import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_barcode_scanner/flutter_barcode_scanner.dart";
import "package:nutrition/screens/home/components/manual_food_bar.dart";
import 'package:nutrition/screens/home/components/manual_nutrition_dialog.dart';
import "package:nutrition/services/database.dart";
import "package:nutrition/services/fatsecret.dart";
import "package:provider/provider.dart";
import "package:nutrition/models/user.dart";
import "package:nutrition/screens/home/components/barcode_bar.dart";
import "package:nutrition/screens/information_screen.dart";
import "package:nutrition/screens/home/components/food_list_card.dart";
import "package:nutrition/screens/home/components/daily_goal_card.dart";
import "package:nutrition/screens/home/components/search_bar.dart";

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FatSecretService _fatSecretService;

  Future<int> scanBarcodeNormal() async {
    String _barcodeScanRes;
    // ignore: unused_local_variable
    String _err = "";

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      _barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
    } on PlatformException {
      _err = "Failed to get platform version.";
    }

    if (!mounted) return null;

    print("Barcode: " + _barcodeScanRes);

    return int.parse(_barcodeScanRes);
  }

  Future<void> barcodeInput(String userUid) async {
    int barcode = await scanBarcodeNormal();
    int itemID = await _fatSecretService.findIDForBarcode(barcode);
    if (itemID > 0) {
      DatabaseService(uid: userUid).addFood(itemID.toString());
    } // else {
    //   Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => ManualNutritionDialogue()));
    // }
  }

  @override
  void initState() {
    super.initState();
    _fatSecretService = FatSecretService();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<User>(context);

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ManualNutritionDialogue();
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.green[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/home_page_bg.jpg"),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * .1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.headline4,
                        children: <InlineSpan>[
                          TextSpan(
                            text: "What are you \neating ",
                            style: TextStyle(
                                color:
                                    Color(Colors.white.value).withOpacity(.90)),
                          ),
                          TextSpan(
                            text: "today?",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  buildFoodList(context),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.headline4,
                            children: <InlineSpan>[
                              TextSpan(
                                text: "Live ",
                                style: TextStyle(color: Colors.black87),
                              ),
                              TextSpan(
                                text: "Healthy",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        SearchBar(),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: GestureDetector(
                      onTap: () => barcodeInput(user.uid),
                      child: BarcodeBar(cardContent: "Scan food barcode"),
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: GestureDetector(
                      onTap: () => _showMyDialog(),
                      child: ManualFoodBar(cardContent: "Record your food"),
                    ),
                  ),
                  SizedBox(height: 30),
                  //Daily Goals
                  buildGoalList(context),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView buildFoodList(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          FoodListCard(
            image: "assets/images/lemon.jpg",
            title: "Lemons",
            subtitle: "Sour and Juicy",
            pressCalories: () {},
            pressInfo: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return InformationScreen();
                  },
                  settings: RouteSettings(
                    arguments: {
                      // Prefix this with the food name
                      "image": "assets/images/lemon.jpg",
                      "lineOne": "Trader Joe's Chelesa",
                      "lineTwo": "17 Calories, 0.17g Fat",
                      "lineThree": "9.56g Carbs, 0.64g Protein",
                      "longDescription":
                          "The lemon, also known as Citrus limon, is a species that belongs to a family of citrus fruit, sharing with many characteristics of other species of citrus fruits. Lemon has been used for culinary and non-culinary purposes throughout the world, notably for its juice. [1]",
                    },
                  ),
                ),
              );
            },
          ),
          FoodListCard(
            image: "assets/images/strawberry.jpg",
            title: "Strawberries",
            subtitle: "Sweet and Sour",
            pressCalories: () {},
            pressInfo: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return InformationScreen();
                  },
                  settings: RouteSettings(
                    arguments: {
                      // Prefix this with the food name
                      "image": "assets/images/strawberry.jpg",
                      "lineOne": "Trader Joe's Chelesa",
                      "lineTwo": "4 Calories, 0g Fat",
                      "lineThree": "0.9g Carbs, 0.1g Protein",
                      "longDescription":
                          "TStrawberries are bright red in appearance. It can be sweet, sour and juicy at the same time. It is an excellent source of vitamin C and manganese. It is also rich in antioxidants and plant compounds. [2]",
                    },
                  ),
                ),
              );
            },
          ),
          FoodListCard(
            image: "assets/images/tomato.jpg",
            title: "Tomatoes",
            subtitle: "For pizza lovers!",
            pressCalories: () {},
            pressInfo: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return InformationScreen();
                  },
                  settings: RouteSettings(
                    arguments: {
                      // Prefix this with the food name
                      "image": "assets/images/tomato.jpg",
                      "lineOne": "Trader Joe's Chelesa",
                      "lineTwo": "22 Calories, 0.2g Fat",
                      "lineThree": "4.8g Carbs, 1.1g Protein",
                      "longDescription":
                          "Tomatoes are the fruit from from the nightshade family native to South America. It is a major source of the antioxidant lycopene which can reduce the risk of heart disease and cancer. It also has a great amount of vitamin C, potassium, folate, and vitamin K. [3]",
                    },
                  ),
                ),
              );
            },
          ),
          SizedBox(width: 30)
        ],
      ),
    );
  }

  Padding buildGoalList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.headline4,
              children: <InlineSpan>[
                TextSpan(
                  text: "Daily ",
                  style: TextStyle(color: Colors.black87),
                ),
                TextSpan(
                  text: "Goals",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 15),
          DailyGoalCard(
            title: "Cook Spinach",
            timeLeft: "8hrs 56min",
          ),
          DailyGoalCard(
            title: "Eat Fruit",
            timeLeft: "6min",
          ),
          SizedBox(height: 0)
        ],
      ),
    );
  }
}
