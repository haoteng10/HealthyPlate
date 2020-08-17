import "package:flutter/material.dart";
import "package:nutrition/services/auth.dart";
import "package:nutrition/screens/loading_screen.dart";

class TempLogin extends StatefulWidget {
  @override
  _TempLoginState createState() => _TempLoginState();
}

class _TempLoginState extends State<TempLogin> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;

  //Text Field State
  String _email = "";
  String _password = "";

  //Error message
  String _errorMessage = "";

  Future<void> authenticate() async {
    print("Email: $_email");
    print("Password: $_password");

    //Changing state so it is showing the loading widget
    setState(() {
      _loading = true;
    });

    dynamic result = await _auth.loginWithEmailAndPassword(_email, _password);
    if (result == null) {
      setState(() {
        _loading = false;
        _errorMessage = "Please enter a valid email!";
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.orange[500],
              elevation: 0.0,
              title: Text("Login Screen"),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        validator: (String val) =>
                            val.isEmpty ? "Enter an email" : null,
                        onChanged: (String val) {
                          setState(() => _email = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        obscureText: true,
                        validator: (String val) => val.length < 5
                            ? "Enter a password with length > 5"
                            : null,
                        onChanged: (String val) {
                          setState(() => _password = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        children: [
                          RaisedButton(
                            color: Colors.blue[800],
                            child: Text("Login",
                                style: TextStyle(color: Colors.white)),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                await authenticate();
                              }
                            },
                          ),
                        ],
                      ),
                      Text(
                        _errorMessage,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  )),
            ),
          );
  }
}
