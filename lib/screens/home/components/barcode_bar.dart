import "package:flutter/material.dart";
import "../../../constants.dart";

class BarcodeBar extends StatefulWidget {
  final String cardContent;

  const BarcodeBar({@required this.cardContent});

  @override
  _BarcodeBarState createState() => _BarcodeBarState();
}

class _BarcodeBarState extends State<BarcodeBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 33,
            color: kShadowColor,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, right: 15),
                child: Icon(Icons.camera),
              ),
              Text(
                widget.cardContent,
                style: TextStyle(
                  fontSize: 16,
                  color: kSecondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
