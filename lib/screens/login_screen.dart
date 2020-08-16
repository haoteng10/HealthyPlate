import "package:flutter/material.dart";
import "package:nutrition/screens/register_screen.dart";
import "package:nutrition/services/auth.dart";
import "../constants.dart";

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();

  String _username;
  String _password;

  void authenticate() async {
    print(_username);
    print(_password);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: Colors.black.withOpacity(.95),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/login_bg.jpg"),
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
                      "Log In",
                      style: TextStyle(
                        color: Colors.white,
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
                    SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: buildPasswordField(),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white30,
                                borderRadius: BorderRadius.circular(29),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    offset: Offset(0, 10),
                                    blurRadius: 20,
                                    // color: kShadowColor,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Guest",
                                    style: TextStyle(
                                      color: Colors.red[300],
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return RegisterScreen();
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white30,
                                borderRadius: BorderRadius.circular(29),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    offset: Offset(0, 10),
                                    blurRadius: 33,
                                    // color: kShadowColor,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.green[400],
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () => authenticate(),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildEmailField() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.circular(29),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 33,
          ),
        ],
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
                  color: kSecondaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextStyle(
                color: kSecondaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              onChanged: (String input) {
                setState(() {
                  _username = input;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buildPasswordField() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.circular(29),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 33,
          ),
        ],
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
                  color: kSecondaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextStyle(
                color: kSecondaryColor,
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
}
