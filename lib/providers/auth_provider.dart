import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mailapp01/utils/shared_preferences_utils.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isVerified = false;
  bool _isRefresh = false;

  String? _resetPhoneNumber;

  String? _deviceId;
  int? _userId;
  int? _complexCount;
  Map<String, dynamic> _userInfo = {};

  bool get isLoggedIn => _isLoggedIn;
  bool get isVerified => _isVerified;
  bool get isRefresh => _isRefresh;

  String? get resetPhoneNumber => _resetPhoneNumber;

  Map<String, dynamic> get userInfo => _userInfo;
  int? get userId => _userId;
  int? get complexCount => _complexCount;
  String? get deviceId => _deviceId;

  checkLoggin() {
    final userInfo = SharedPreferencesUtils.getStringValuesSF("userInfo");
    _userInfo = userInfo != '' ? jsonDecode(userInfo) : {};
    _userId = SharedPreferencesUtils.getIntValuesSF("userId");
    _isLoggedIn = SharedPreferencesUtils.getBoolValuesSF("isLoggedin");
    _complexCount = SharedPreferencesUtils.getIntValuesSF("complexCount");
    _deviceId = SharedPreferencesUtils.getStringValuesSF("deviceId");
    _isVerified = _userInfo["is_verified"] == 1;
    _resetPhoneNumber = SharedPreferencesUtils.getStringValuesSF("resetPhone");
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

  refreshTrue() {
    _isRefresh = true;
    notifyListeners();
  }

  refreshFalse() {
    _isRefresh = false;
  }
}
