import "package:flutter/material.dart";
import "package:flutter_barcode_scanner/flutter_barcode_scanner.dart";
import "package:nutrition/components/barcode_scanner.dart";
import "package:nutrition/screens/information_screen.dart";
import "package:nutrition/screens/loading_screen.dart";
import "package:nutrition/components/food_list_card.dart";
import "package:nutrition/components/daily_goal_card.dart";
import "package:nutrition/components/search_bar.dart";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Move this to barcode_scanner.dart file
  String _scanBarcode = "Unknown";

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } catch (err) {
      print(err);
      barcodeScanRes = "Failed to get platform version.";
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                            style: TextStyle(color: Colors.white70),
                          ),
                          TextSpan(
                            text: "today?",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        FoodListCard(
                          image: "assets/images/lemon.jpg",
                          title: "Lemons",
                          subtitle: "Short desc",
                          pressCalories: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Loading();
                                },
                              ),
                            );
                          },
                          pressInfo: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Information();
                                },
                                settings: RouteSettings(
                                  arguments: {
                                    // Prefix this with the food name
                                    "image": "assets/images/lemon.jpg",
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        FoodListCard(
                          image: "assets/images/strawberry.jpg",
                          title: "Strawberries",
                          subtitle: "A fact here!",
                          pressCalories: () {},
                          pressInfo: () {},
                        ),
                        FoodListCard(
                          image: "assets/images/tomato.jpg",
                          title: "Tomatoes",
                          subtitle: "For pizza lovers!",
                          pressCalories: () {},
                          pressInfo: () {},
                        ),
                        FoodListCard(
                          image: "assets/images/broccoli.jpg",
                          title: "Broccoli",
                          subtitle: "The classic greens.",
                          pressCalories: () {},
                          pressInfo: () {},
                        ),
                        SizedBox(width: 30)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.headline4,
                            children: <InlineSpan>[
                              TextSpan(text: "Live "),
                              TextSpan(
                                text: "Healthy",
                                style: TextStyle(
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
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: GestureDetector(
                      onTap: scanBarcodeNormal,
                      child: BarcodeScanner(),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.headline4,
                            children: <InlineSpan>[
                              TextSpan(text: "Daily "),
                              TextSpan(
                                text: "Goals",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        NutritionLabel(
                          title: "Cook Spinach",
                          timeLeft: "8hrs 56min",
                        ),
                        NutritionLabel(
                          title: "Eat Fruit",
                          timeLeft: "6min",
                        ),
                        SizedBox(height: 20)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
