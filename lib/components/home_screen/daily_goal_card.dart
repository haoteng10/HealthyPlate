import "package:flutter/material.dart";
import '../../constants.dart';

class DailyGoalCard extends StatelessWidget {
  final String title;
  final String timeLeft;

  const DailyGoalCard({Key key, this.title, this.timeLeft}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      margin: EdgeInsets.only(bottom: 16),
      width: size.width - 48,
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
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$title \n",
                  style: TextStyle(
                    fontSize: 16,
                    color: kBlackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "$timeLeft left",
                  style: TextStyle(color: kLightBlackColor),
                ),
              ],
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
