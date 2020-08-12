import "package:flutter/material.dart";
import "package:nutrition/components/app_bar.dart";
import "../constants.dart";

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    final Map<String, String> arguments = ModalRoute.of(context).settings.arguments;
    final String image = arguments["image"];

    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: <Widget>[
          ItemImage(
            imgSrc: image,
          ),
          Expanded(
            child: ItemInfo(),
          ),
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
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: <Widget>[
          storeName(name: "Groccery Store Name"),
          Text(
            "The long description goes here",
            style: TextStyle(
              height: 1.5,
            ),
          ),
          SizedBox(height: size.height * 0.1),
        ],
      ),
    );
  }

  Row storeName({String name}) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.location_on,
          color: kSecondaryColor,
        ),
        SizedBox(width: 10),
        Text(name),
      ],
    );
  }
}
