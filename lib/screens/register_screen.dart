import "package:flutter/material.dart";
import "package:nutrition/screens/loading_screen.dart";
import "package:nutrition/services/auth.dart";

import "../constants.dart";

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _auth = AuthService();

  String _email;
  String _password;
  bool _loading = false;
  String _errorMessage = "";

  Future<void> authenticate() async {
    print("Email: $_email");
    print("Password: $_password");

    //Changing state so it is showing the loading widget
    setState(() {
      _loading = true;
    });

    dynamic result =
        await _auth.registerWithEmailAndPassword(_email, _password);
    if (result == null) {
      setState(() {
        _errorMessage = "Please enter a valid email!";
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? LoadingScreen()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              width: double.infinity,
              // height: size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/register_bg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Spacer(),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: buildEmailField(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: buildPasswordField(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: buildActionButton(
                                  context, "Register", Colors.purple, () async {
                                await authenticate();
                              }),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  GestureDetector buildActionButton(
      BuildContext context, String name, Color color, Function action) {
    return GestureDetector(
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(29),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      onTap: action,
    );
  }

  Container buildPasswordField() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(29),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 5),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Icon(
                    Icons.lock,
                    color: kIconColor,
                  ),
                ),
                hintText: "Password",
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              obscureText: true,
              onChanged: (String input) {
                setState(() {
                  _password = input;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buildEmailField() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(29),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 5),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Icon(
                    Icons.email,
                    color: kIconColor,
                  ),
                ),
                hintText: "Email",
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              onChanged: (String input) {
                setState(() {
                  _email = input;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
