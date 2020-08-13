import 'package:flutter/material.dart';
import 'package:nutrition/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleScreen;
  Register({this.toggleScreen});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  //Text Field State
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[500],
        elevation: 0.0,
        title: Text("Signup Screen"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
            child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            TextFormField(
              onChanged: (val) {
                setState(() => email = val);
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              obscureText: true,
              onChanged: (val) {
                setState(() => password = val);
              },
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                RaisedButton(
                  color: Colors.blue[800],
                  child:
                      Text("Register", style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    print("Email: $email");
                    print("Password: $password");
                  },
                ),
                SizedBox(width: 10.00),
                RaisedButton(
                  color: Colors.blue[800],
                  child: Text("Login", style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    widget.toggleScreen();
                  },
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
