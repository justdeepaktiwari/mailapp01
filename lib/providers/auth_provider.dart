import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mailapp01/utils/shared_preferences_utils.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  late int _userId;
  Map<String, dynamic> _userInfo = {};

  bool get isLoggedIn => _isLoggedIn;
  Map<String, dynamic> get userInfo => _userInfo;
  int get userId => _userId;

  checkLoggin() {
    _userInfo = jsonDecode(
      SharedPreferencesUtils.getStringValuesSF("userInfo"),
    );
    _userId = SharedPreferencesUtils.getIntValuesSF("userId");
    _isLoggedIn = SharedPreferencesUtils.getBoolValuesSF("isLoggedin");
  }

  login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  logout() async {
    _isLoggedIn = false;
    _userInfo = {};
    notifyListeners();
  }
}
