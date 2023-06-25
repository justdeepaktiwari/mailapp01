import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  void checkLoginStatus() async {
    _isLoggedIn = await getBoolValuesSF("isLoggedIn");
    notifyListeners();
  }

  Future<void> login() async {
    // Perform your login logic here
    // Update the _isLoggedIn value accordingly

    addBoolToSF("isLoggedIn", true);
    _isLoggedIn = await getBoolValuesSF("isLoggedIn");
    notifyListeners();
  }

  Future<void> logout() async {
    // Perform your logout logic here
    // Update the _isLoggedIn value accordingly
    addBoolToSF("isLoggedIn", false);
    _isLoggedIn = await getBoolValuesSF("isLoggedIn");
    notifyListeners();
  }

  getBoolValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool boolValue = prefs.getBool(key) ?? false;
    return boolValue;
  }

  addBoolToSF(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }
}
