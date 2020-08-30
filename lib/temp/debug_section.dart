import "package:flutter/material.dart";
import "package:nutrition/temp/firestore_screen.dart";
import "package:nutrition/services/auth.dart";
import "package:nutrition/temp/temp_login.dart";
import "package:nutrition/temp/temp_register.dart";
import "package:provider/provider.dart";
import "package:nutrition/models/user.dart";

class Debug extends StatefulWidget {
  @override
  _DebugState createState() => _DebugState();
}

class _DebugState extends State<Debug> {
  bool _isLoggedIn = false;

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user != null && _isLoggedIn == false) {
      //Got updated user data & user in not logged in view --> Change isLoggedIn to true
      setState(() {
        _isLoggedIn = true;
      });
    } else if (user == null && _isLoggedIn == true) {
      //Got updated user data that is null & user has a logged in view --> Change to not logged in view
      setState(() {
        _isLoggedIn = false;
      });
    }

    if (!_isLoggedIn) {
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FirestoreDebug()));
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
