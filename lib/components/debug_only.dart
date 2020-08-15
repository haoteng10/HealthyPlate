import "package:flutter/material.dart";
import "package:nutrition/screens/debug_screen.dart";
import "package:nutrition/services/auth.dart";
import "package:nutrition/temp/temp_login.dart";
import 'package:nutrition/temp/temp_register.dart';
import "package:provider/provider.dart";
import "package:nutrition/models/user.dart";

class DebugOnly extends StatefulWidget {
  @override
  _DebugOnlyState createState() => _DebugOnlyState();
}

class _DebugOnlyState extends State<DebugOnly> {
  bool isLoggedIn = false;

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user != null && isLoggedIn == false) {
      //Got updated user data & user in not logged in view --> Change isLoggedIn to true
      setState(() {
        isLoggedIn = true;
      });
    } else if (user == null && isLoggedIn == true) {
      //Got updated user data that is null & user has a logged in view --> Change to not logged in view
      setState(() {
        isLoggedIn = false;
      });
    }

    if (!isLoggedIn) {
      return Container(
        //DEBUG BUTTON
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.headline4,
                  children: <InlineSpan>[
                    TextSpan(text: "Debug "),
                    TextSpan(
                      text: "Only",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Row(children: <Widget>[
                RaisedButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TempLogin()));
                    },
                    icon: Icon(Icons.transit_enterexit),
                    label: Text("Login")),
                SizedBox(width: 10.0),
                RaisedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TempRegister()));
                    },
                    icon: Icon(Icons.person_add),
                    label: Text("Register")),
              ]),
            ],
          ),
        ),
      );
    } else {
      return Container(
        //DEBUG BUTTON
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.headline4,
                  children: <InlineSpan>[
                    TextSpan(text: "Debug "),
                    TextSpan(
                      text: "Only",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  OutlineButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Debug()));
                      },
                      child: Text("Firestore")),
                  SizedBox(width: 10.0),
                  OutlineButton.icon(
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    icon: Icon(Icons.person),
                    label: Text("Sign Out"),
                  )
                ],
              )
            ],
          ),
        ),
      );
    }
  }
}
