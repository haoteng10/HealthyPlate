import "package:flutter/material.dart";
import "package:nutrition/screens/home_screen.dart";
import "package:nutrition/screens/login_screen.dart";
import 'package:nutrition/screens/register_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      selectedItemColor: Colors.amber[800],
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });

        print(index);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return _currentIndex == 0
                  ? HomeScreen()
                  : _currentIndex == 1 ? RegisterScreen() : _currentIndex == 2 ? LoginScreen() : null;
            },
          ),
        );
      },
    );
  }
}
