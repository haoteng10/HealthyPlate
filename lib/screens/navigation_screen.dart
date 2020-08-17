import "package:flutter/material.dart";
import "package:nutrition/screens/login_screen.dart";
import 'package:nutrition/screens/register_screen.dart';
import "package:provider/provider.dart";
import "package:nutrition/models/user.dart";

import "home_screen.dart";

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  // Add global state to determine if the login button should change to account
  bool _isLoggedIn;

  int _currentIndex = 0;
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

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            title: Text("Register"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text("Login"),
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.teal,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [HomeScreen(), RegisterScreen(), LoginScreen()],
      ),
    );
  }
}
