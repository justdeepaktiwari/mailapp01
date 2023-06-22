import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> login() async {
    // Perform your login logic here
    // Update the _isLoggedIn value accordingly
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logout() async {
    // Perform your logout logic here
    // Update the _isLoggedIn value accordingly
    _isLoggedIn = false;
    notifyListeners();
  }
}
