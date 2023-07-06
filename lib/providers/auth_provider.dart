import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  logout() async {
    _isLoggedIn = false;
    notifyListeners();
  }
}
