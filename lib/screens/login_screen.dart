import "package:flutter/material.dart";
import "package:nutrition/services/auth.dart";
import "package:nutrition/screens/loading_screen.dart";
import "../constants.dart";

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";
  bool _loading = false;
  bool _invalidEmail = false;
  bool _invalidPassword = false;
  String _firebaseError = "";

  Future<void> anonAuthenticate() async {
    //Changing state so it is showing the loading widget
    setState(() {
      _loading = true;
    });

    dynamic result = await _auth.signInAnon();
    if (result == null) {
      setState(() {
        _firebaseError = "Error occurs!";
        _loading = false;
      });
    }
  }

  Future<void> authenticate() async {
    setState(() {
      _loading = true;
      _invalidEmail = false;
      _invalidPassword = false;
    });

    if (_email.length < 1 || !_email.contains("@")) {
      setState(() {
        _invalidEmail = true;
      });
    }

    if (_password.length < 1) {
      setState(() {
        _invalidPassword = true;
      });
    }

    if (!_invalidEmail && !_invalidPassword) {
      dynamic result = await _auth.loginWithEmailAndPassword(_email, _password);
      if (result == null) {
        setState(() {
          _firebaseError = "Please register first!";
        });
      } else {
        return;
      }
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return _loading
        ? LoadingScreen()
        : Scaffold(
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
                child: Form(
                  key: _formKey,
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
                            SizedBox(
                              height: 8,
                            ),
                            _invalidEmail
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30),
                                        child: Text(
                                          "Invalid email",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            SizedBox(height: 30), //Change this back to 30
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: buildPasswordField(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            _invalidPassword
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30),
                                        child: Text(
                                          "Invalid password",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                    onTap: () async {
                                      await anonAuthenticate();
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                    onTap: () async {
                                      await authenticate();
                                      // if (_email.length > 0 && _password.length > 0) {
                                      //   await authenticate();
                                      // }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _firebaseError,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
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
              // validator: (String val) {
              //   if (val.isEmpty) {
              //     _invalidEmail = true;
              //     return;
              //   } else {
              //     setState(() {
              //       _invalidEmail = false;
              //     });
              //   }
              //   return null;
              // },
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
                  _email = input;
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
              // validator: (String val) {
              //   if (val.length < 5) {
              //     setState(() {
              //       _invalidPassword = true;
              //     });
              //     return;
              //   } else {
              //     setState(() {
              //       _invalidPassword = false;
              //     });
              //   }
              //   return null;
              // },
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
