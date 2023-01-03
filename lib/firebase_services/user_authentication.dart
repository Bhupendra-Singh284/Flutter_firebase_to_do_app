import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_to_do_app/App_pages/Homepage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthenticateUsers with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  void pushHomePage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Homepage()));
  }

  bool isUseravailable() {
    if (_user != null) {
      return true;
    }
    return false;
  }

  Future createUser(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user = credential.user;
      if (_user != null) {
        print("user created");
        notifyListeners();
        return _user;
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
        msg: e.message.toString(),
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.white,
        textColor: Colors.black,
      );
    } catch (e) {
      _user = null;
      notifyListeners();
      print(e);
    }
  }

  Future signInUser(String email, String password, BuildContext context) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _user = credential.user;
      if (_user != null) {
        notifyListeners();
        return _user;
      } else {
        _user = null;
        return null;
      }
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
        msg: e.message.toString(),
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.white,
        textColor: Colors.black,
      );
    } catch (e) {
      _user = null;
      notifyListeners();
      print(e);
    }
  }
}
