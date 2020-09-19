import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrition/models/user.dart';
import 'package:nutrition/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create user obj based on Firebase User
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //Auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        // .map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser); //Same as the line above
  }

  //Sign In Anonymously
  Future<dynamic> signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      // Create a user document in users collection
      await DatabaseService(uid: user.uid).createUser("null");
      // Return the user according to the user model
      return _userFromFirebaseUser(user);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  //Login Via Email & Password
  Future<dynamic> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      // return user;
      return _userFromFirebaseUser(user);
    } catch (err) {
      print("Login with email & password failed!");
      print(err.toString());
      return null;
    }
  }

  //Register with Email & Password
  Future<dynamic> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      await DatabaseService(uid: user.uid).createUser("null");

      return _userFromFirebaseUser(user);
    } catch (err) {
      print("Register with email & password failed!");
      print(err.toString());
      return null;
    }
  }

  //Sign Out
  Future<dynamic> signOut() async {
    try {
      return await _auth.signOut();
    } catch (err) {
      print(err.toString());
      return null;
    }
  }
}
