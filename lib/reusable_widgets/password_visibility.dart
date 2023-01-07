import 'package:flutter/cupertino.dart';

class PasswordVisibility with ChangeNotifier {
  bool isVisible = false;

  void toggleVisibility() {
    isVisible = !isVisible;
    print("notified");
    //change values in login and signup class by notifying them about the change through provider
    notifyListeners();
  }
}
