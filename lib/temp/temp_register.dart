import "package:flutter/material.dart";
import "package:nutrition/services/auth.dart";
import "package:nutrition/screens/loading_screen.dart";

class TempRegister extends StatefulWidget {
  @override
  _TempRegisterState createState() => _TempRegisterState();
}

class _TempRegisterState extends State<TempRegister> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  //Text Field State
  String _email = "";
  String _password = "";

  String errorMessage = "";

  void authenticate() async {
    print("Email: $_email");
    print("Password: $_password");

    //Changing state so it is showing the loading widget
    setState(() {
      loading = true;
    });

    dynamic result =
        await _auth.registerWithEmailAndPassword(_email, _password);
    if (result == null) {
      setState(() {
        loading = false;
        errorMessage = "Please enter a valid email!";
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
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
                        validator: (val) =>
                            val.isEmpty ? "Enter an email" : null,
                        onChanged: (val) {
                          setState(() => _email = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        obscureText: true,
                        validator: (val) => val.length < 5
                            ? "Enter a password with length > 5"
                            : null,
                        onChanged: (val) {
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
                                authenticate();
                              }
                            },
                          ),
                        ],
                      ),
                      Text(
                        errorMessage,
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
