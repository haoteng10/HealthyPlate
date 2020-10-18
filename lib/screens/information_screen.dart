import "package:flutter/material.dart";
import "../constants.dart";

class InformationScreen extends StatefulWidget {
  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, String> arguments =
        ModalRoute.of(context).settings.arguments;
    final String image = arguments["image"];
    final String lineOne = arguments["lineOne"];
    final String lineTwo = arguments["lineTwo"];
    final String lineThree = arguments["lineThree"];
    final String description = arguments["longDescription"];

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
            child: ItemInfo(
              lineOne: lineOne,
              lineTwo: lineTwo,
              lineThree: lineThree,
              description: description,
            ),
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
  final String lineOne;
  final String lineTwo;
  final String lineThree;
  final String description;

  const ItemInfo({
    this.lineOne,
    this.lineTwo,
    this.lineThree,
    this.description,
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
            name: this.lineOne ?? "",
            icon: Icons.location_on,
          ),
          SizedBox(height: 10),
          metaData(
            name: this.lineTwo ?? "",
            icon: Icons.check_circle_outline,
          ),
          SizedBox(height: 10),
          metaData(
            name: this.lineThree ?? "",
            icon: Icons.check_circle_outline,
          ),
          SizedBox(height: 20),
          Text(
            this.description ?? "",
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
