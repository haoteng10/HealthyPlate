import "package:flutter/material.dart";
import "package:nutrition/screens/login_screen.dart";
import "package:nutrition/screens/register_screen.dart";
import "package:nutrition/screens/statistics_screen.dart";
import "package:nutrition/screens/user_profile_screen.dart";
import "package:provider/provider.dart";
import "package:nutrition/models/user.dart";

import "home_screen.dart";

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  // Add global state to determine if the login button should change to account
  bool _isLoggedIn = false;

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user != null && _isLoggedIn == false) {
      //Got updated user data & user in not logged in view --> Change isLoggedIn to true
      setState(() {
        _isLoggedIn = true;
        // After the user logged in, the user should be moved to the home screen
        _currentIndex = 0;
      });
    } else if (user == null && _isLoggedIn == true) {
      //Got updated user data that is null & user has a logged in view --> Change to not logged in view
      setState(() {
        _isLoggedIn = false;
        // After the user logged out, the user should be moved to the home screen
        _currentIndex = 0;
      });
    }

    if (!_isLoggedIn) {
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
    } else {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.table_chart),
              title: Text("Statistics"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
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
          children: [HomeScreen(), StatisticsScreen(), UserProfileScreen()],
        ),
      );
    }
  }
}
