import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_barcode_scanner/flutter_barcode_scanner.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oauth2/oauth2.dart';
import "package:http/http.dart" as http;
import "package:nutrition/components/barcode_scanner.dart";
import "package:nutrition/screens/information_screen.dart";
import "package:nutrition/screens/loading_screen.dart";
import "package:nutrition/components/food_list_card.dart";
import "package:nutrition/components/daily_goal_card.dart";
import "package:nutrition/components/search_bar.dart";
import 'package:nutrition/temp/debug_section.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Move this to barcode_scanner.dart file
  // ignore: unused_field
  String _scanBarcode = "Unknown";
  Client _oauthClient;
  // DateTime _oauthExpDate;

  Future<void> fetchToken() async {
    final String _fatSecretClientID = DotEnv().env["FATSECRET_CLIENT_ID"];
    final String _fatSecretClientSecret =
        DotEnv().env["FATSECRET_CLIENT_SECRET"];

    final _authorizationEndpoint =
        Uri.parse("https://oauth.fatsecret.com/connect/token");
    Client client = await clientCredentialsGrant(
        _authorizationEndpoint, _fatSecretClientID, _fatSecretClientSecret);

    setState(() {
      _oauthClient = client;
      // _oauthExpDate = client.credentials.expiration;
    });

    http.Response response = await _oauthClient.post(
        "https://platform.fatsecret.com/rest/server.api?method=food.find_id_for_barcode&barcode=075720000814&format=json");
    print(response.body);
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = "Failed to get platform version.";
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });

    //Run the fetchAPI function
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                  SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: GestureDetector(
                      onTap: scanBarcodeNormal,
                      child: BarcodeScanner(),
                    ),
                  ),
                  SizedBox(height: 30),
                  //Daily Goals
                  buildGoalList(context),
                  SizedBox(height: 15),
                  //Debug Section
                  Debug(),
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        RaisedButton(
                            child: Text("Fetch Token"),
                            onPressed: () async {
                              await fetchToken();
                            }),
                      ],
                    ),
                  )
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
            subtitle: "Short desc",
            pressCalories: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoadingScreen();
                  },
                ),
              );
            },
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
