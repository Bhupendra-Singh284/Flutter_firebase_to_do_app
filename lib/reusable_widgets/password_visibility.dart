import 'package:flutter/cupertino.dart';

class PasswordVisibility with ChangeNotifier {
  bool isVisible = false;

  void toggleVisibility() {
    isVisible = !isVisible;
    print("notified");
    print(PasswordVisibility().hasListeners);
    notifyListeners();
  }
}
