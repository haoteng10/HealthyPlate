import "package:flutter/material.dart";
import "package:nutrition/components/app_bar.dart";
import 'package:nutrition/components/rounded_button.dart';
import 'package:nutrition/screens/list_foods_screen.dart';
import "package:nutrition/services/auth.dart";

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFE6F4FF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/healthy.jpg"),
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
                            text: "The greatest wealth \nis ",
                            style: TextStyle(color: Color(Colors.white.value).withOpacity(.90)),
                          ),
                          TextSpan(
                            text: "health.",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 90),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: RoundedButton(
                      press: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ListFoodsScreen()));
                      },
                      text: "View Your Foods",
                      verticalPadding: 18,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: RoundedButton(
                      press: () async {
                        await _auth.signOut();
                      },
                      text: "Sign Out",
                      verticalPadding: 18,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/welcome.png",
                      height: size.height * 0.35,
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
}
