import 'package:flutter/cupertino.dart';

class PasswordVisibility with ChangeNotifier {
  bool isVisible = false;

  void toggleVisibility() {
    isVisible = !isVisible;
    //change values in login and signup class by notifying them about the change through provider
    notifyListeners();
  }
}
