import 'dart:convert';

import 'package:mailapp01/api/api_endpoints.dart';
import 'package:mailapp01/api/api_helpers.dart';
import 'package:mailapp01/services/auth/login_body.dart';
import 'package:mailapp01/services/auth/register_body.dart';
import 'package:mailapp01/utils/shared_preferences_utils.dart';

class AuthService {
  Map<String, dynamic> registerBody = {
    "name": null,
    "email": null,
    "phone_number": null,
    "password": null,
    "password_confirmation": null,
  };

  Map<String, dynamic> loginBody = {
    "email": null,
    "password": null,
  };

  static Future<Map<String, dynamic>> registerUser(
    RegisterBody registerBody,
  ) async {
    final response = await ApiHelper.post(
      ApiEndpoints.register,
      registerBody.bodyData(),
      ApiHelper.guestRequestHeaders(),
    );

    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      await SharedPreferencesUtils.addBoolToSF("isLoggedin", true);
      await SharedPreferencesUtils.addStringToSF(
        "token",
        result["token"]["plainTextToken"],
      );
      return result;
    } else if (response.statusCode == 422) {
      return result;
    }

    return {
      "success": false,
      "message": "Error encountry try again!",
    };
  }

  static Future<Map<String, dynamic>> loginUser(LoginBody loginBody) async {
    final response = await ApiHelper.post(
      ApiEndpoints.login,
      loginBody.bodyData(),
      ApiHelper.guestRequestHeaders(),
    );

    final result = jsonDecode(response.body);

    if (response.statusCode == 200) {
      await SharedPreferencesUtils.addBoolToSF("isLoggedin", true);
      await SharedPreferencesUtils.addStringToSF(
        "token",
        result["data"]["token"]["plainTextToken"],
      );

      return result;
    } else if (response.statusCode == 401) {
      return result;
    }

    return {
      "success": false,
      "message": "Error encounter try again!",
    };
  }

  static Future<Map<String, dynamic>> logoutUser() async {
    final response = await ApiHelper.post(
      ApiEndpoints.logout,
      {},
      ApiHelper.authRequestHeaders(),
    );
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      SharedPreferencesUtils.removeValue(["isLoggedin", "token"]);
      return result;
    } else {
      return result;
    }
  }
}
