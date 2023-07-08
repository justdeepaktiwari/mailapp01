import 'package:flutter/material.dart';
import 'package:mailapp01/utils/shared_preferences_utils.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  checkLoggin() {
    _isLoggedIn = SharedPreferencesUtils.getBoolValuesSF("isLoggedin");
  }

  login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  logout() async {
    _isLoggedIn = false;
    notifyListeners();
  }
}
