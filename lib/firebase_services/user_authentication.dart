import 'package:firebase_auth/firebase_auth.dart';

class AuthenticateUsers {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future createUser(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;
      if (user != null) {
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}
