import "package:flutter/material.dart";
import "package:nutrition/services/auth.dart";

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          Text(
            "User Profile",
            style: TextStyle(
              fontSize: 32.0,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16.0),
          RaisedButton(
            onPressed: () async {
              await _auth.signOut();
            },
            textColor: Colors.white,
            padding: EdgeInsets.all(0.0),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Sign Out",
                style: TextStyle(fontSize: 25),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
