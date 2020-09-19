import "package:flutter/material.dart";
import "package:nutrition/services/auth.dart";
import 'package:nutrition/components/loading.dart';

class TempRegister extends StatefulWidget {
  @override
  _TempRegisterState createState() => _TempRegisterState();
}

class _TempRegisterState extends State<TempRegister> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;

  //Text Field State
  String _email = "";
  String _password = "";

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
              title: Text("Register Screen"),
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
                            child: Text("Register",
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
