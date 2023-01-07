import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticateUsers with ChangeNotifier {
  //create firebase auth object for authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create a google user for google sign in
  final googleUser = GoogleSignIn();

  //create a firebase user object to get details eg email, name ,image
  User? user;

  //check if  we have any user present or not
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

      //set the user object to current user
      user = userCredential.user;

      if (user != null) {
        if (check == true) {
          //check if it is new account from login page
          if (userCredential.additionalUserInfo!.isNewUser) {
            //incase of new account delete the account and throw exception
            user?.delete();
            throw FirebaseAuthException(code: "No registered account found");
          } else {
            notifyListeners();
          }
        } else {
          //if google authentication called from sign up page give user entry  to his account even if the user has already made a google account
          notifyListeners();
          Navigator.pop(context);
        }
      }
    } on FirebaseException catch (e) {
      //on exception show user the message
      Fluttertoast.showToast(
          msg: e.code.toString(),
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.white,
          textColor: Colors.black);
    }
  }

  //for signing out a user from the app
  void signoutUser() async {
    _auth.signOut();
    googleUser.disconnect();
    user = null;
    notifyListeners();
  }
}
