import "package:flutter/material.dart";
// import 'package:nutrition/deprecated/bottom_nav_bar.dart';
import "../constants.dart";

class InformationScreen extends StatefulWidget {
  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, String> arguments = ModalRoute.of(context).settings.arguments;
    final String image = arguments["image"];

    return Scaffold(
      // appBar: appBar(context, "Nutritional", "Information"),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          ItemImage(
            imgSrc: image,
          ),
          Expanded(
            child: ItemInfo(),
          ),
          // Put this in the same container as desc
        ],
      ),
    );
  }
}

class ItemImage extends StatelessWidget {
  final String imgSrc;
  const ItemImage({
    Key key,
    this.imgSrc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Image.asset(
      imgSrc,
      height: size.height * 0.3,
      width: double.infinity,
      fit: BoxFit.contain,
    );
  }
}

class ItemInfo extends StatelessWidget {
  const ItemInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 100,
            color: kShadowColor,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 5),
          metaData(
            name: "Trader Joe's Chelesa",
            icon: Icons.location_on,
          ),
          SizedBox(height: 10),
          metaData(
            name: "17 Calories, 0.17g Fat",
            icon: Icons.check_circle_outline,
          ),
          SizedBox(height: 10),
          metaData(
            name: "9.56g Carbs, 0.64g Protein",
            icon: Icons.check_circle_outline,
          ),
          SizedBox(height: 20),
          Text(
            "The lemon, Citrus limon, is a species of small evergreen tree in the flowering plant family Rutaceae, native to South Asia, primarily North eastern India. The tree's ellipsoidal yellow fruit is used for culinary and non-culinary purposes throughout the world, primarily for its juice, which has both culinary and cleaning uses.",
            style: TextStyle(height: 1.5, fontSize: 16),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
              margin: EdgeInsets.only(bottom: 16),
              width: size.width / 2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(38.5),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 33,
                    color: kShadowColor,
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Return home",
                          style: TextStyle(
                            fontSize: 16,
                            color: kBlackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Row metaData({@required String name, @required IconData icon}) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: kSecondaryColor,
        ),
        SizedBox(width: 10),
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
