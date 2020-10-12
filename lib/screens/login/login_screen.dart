import "package:flutter/material.dart";
import "package:nutrition/components/app_bar.dart";
import "package:nutrition/screens/login/components/form_input.dart";
import "package:nutrition/screens/login/register/register_screen.dart";
import "package:nutrition/services/auth.dart";
import "package:nutrition/components/loading.dart";
import "../../constants.dart";

/* When route is pushed on, the bottom Nav bar dissapears, use appbar? */
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
  bool _firebaseError = false;

  Future<void> anonAuthenticate() async {
    setState(() {
      _loading = true;
    });

    dynamic result = await _auth.signInAnon();
    if (result == null) {
      setState(() {
        _firebaseError = true;
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
          _firebaseError = true;
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

    if (_loading) {
      return LoadingScreen();
    } else {
      return Scaffold(
        /* Error thrown if this is the first page they visit */
        appBar: appBar(context, "Sign In"),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height * 0.04),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Welcome back",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Login in with your email and password \nor continue as a guest",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                        SizedBox(height: 30),
                        FormInput(
                          obscure: false,
                          label: "Email",
                          hintText: "Enter your email",
                          icon: Icons.email,
                          press: (String input) {
                            setState(() {
                              _email = input;
                            });
                          },
                        ),
                        SizedBox(height: 8),
                        if (_invalidEmail)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Text(
                                  "Invalid email",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        SizedBox(height: 30),
                        FormInput(
                          obscure: true,
                          label: "Password",
                          hintText: "Enter your password",
                          icon: Icons.lock,
                          press: (String input) {
                            setState(() {
                              _password = input;
                            });
                          },
                        ),
                        SizedBox(height: 8),
                        if (_invalidPassword)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Text(
                                  "Invalid password",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (_firebaseError)
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 25),
                              child: Text(
                                "Please register to continue.",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          )
                        else
                          SizedBox(height: 30),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 33,
                                color: kShadowColor,
                              ),
                            ],
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: kPrimaryColor,
                              onPressed: () async {
                                await authenticate();
                              },
                              child: Text(
                                "CONTINUE",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 33,
                                color: kShadowColor,
                              ),
                            ],
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: Color(0xFFffc9b5),
                              onPressed: () async {
                                await anonAuthenticate();
                              },
                              child: Text(
                                "GUEST",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(fontSize: 16),
                            ),
                            GestureDetector(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 16,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ),
                                );
                              },
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
  }
}
