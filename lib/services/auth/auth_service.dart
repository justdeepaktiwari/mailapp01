import 'dart:convert';

import 'package:mailapp01/api/api_endpoints.dart';
import 'package:mailapp01/api/api_helpers.dart';
import 'package:mailapp01/services/auth/login_body.dart';
import 'package:mailapp01/services/auth/register_body.dart';
import 'package:mailapp01/utils/shared_preferences_utils.dart';

class AuthService {
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
      await SharedPreferencesUtils.addStringToSF(
        "token",
        result["data"]["token"]["plainTextToken"],
      );
      if (result["data"]["token"]["plainTextToken"] != null) {
        await SharedPreferencesUtils.addBoolToSF("isLoggedin", true);
        await SharedPreferencesUtils.addIntToSF(
            "userId", result["data"]["user"]["id"]);
      }
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
      await SharedPreferencesUtils.addStringToSF(
        "token",
        result["data"]["token"]["plainTextToken"],
      );
      if (result["data"]["token"]["plainTextToken"] != null) {
        await SharedPreferencesUtils.addBoolToSF("isLoggedin", true);
        await SharedPreferencesUtils.addIntToSF(
            "userId", result["data"]["user"]["id"]);
      }
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
      SharedPreferencesUtils.removeValue([
        "isLoggedin",
        "token",
        "userId",
      ]);
      return result;
    } else {
      if (SharedPreferencesUtils.removeValue([
        "isLoggedin",
        "token",
        "userId",
      ])) {
        return {"success": true, "message": "Logout successfully!"};
      }
      return result;
    }
  }
}
