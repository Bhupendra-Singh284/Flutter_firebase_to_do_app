import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_to_do_app/App_pages/Homepage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticateUsers with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleUser = GoogleSignIn();
  User? user;

  void pushHomePage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Homepage()));
  }

  bool isUseravailable() {
    if (user != null) {
      return true;
    }
    return false;
  }

//Create New User with Email and Password
  Future createUser(String email, String password) async {
    try {
      final userCredential =
          EmailAuthProvider.credential(email: email, password: password);

      final linkUserCredential = await FirebaseAuth.instance.currentUser
          ?.linkWithCredential(userCredential);

      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      user = credential.user;
      if (user != null) {
        print("user created");
        notifyListeners();
        return user;
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
      user = null;
      notifyListeners();
      print(e);
    }
  }

//Email and Password Login
  Future signInUser(String email, String password, BuildContext context) async {
    try {
      await _auth.signOut();
      await googleUser.signOut();

      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      user = credential.user;
      if (user != null) {
        notifyListeners();
        return user;
      }
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
        msg: e.message.toString(),
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.white,
        textColor: Colors.black,
      );
    } catch (e) {
      user = null;
      notifyListeners();
      print(e);
    }
  }

//Google Sign in
  Future signInWithGoogle(bool check, BuildContext context) async {
    // Trigger the authentication flow
    try {
      googleUser.signOut();
      _auth.signOut();

      final GoogleSignInAccount? googleAccUser = await googleUser.signIn();

      if (googleAccUser == null) {
        print("nothing selected");
        return;
      }
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleAccUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      user = userCredential.user;

      if (user != null) {
        print("user not null");
        if (check == true) {
          print("check is true");
          if (userCredential.additionalUserInfo!.isNewUser) {
            print("new user");
            user?.delete();
            throw FirebaseAuthException(code: "No registered account found");
          } else {
            notifyListeners();
            print("old user");
          }
        } else {
          print("sign in new user");
          notifyListeners();
          Navigator.pop(context);
        }
      }
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
          msg: e.code.toString(),
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.white,
          textColor: Colors.black);
    } catch (e) {
      print(e);
    }
  }

  void signoutUser() async {
    _auth.signOut();
    googleUser.disconnect();
    user = null;
    print("function callled");
    notifyListeners();
  }
}
