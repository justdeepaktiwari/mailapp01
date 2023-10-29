import 'dart:convert';

import 'package:mailapp01/api/api_endpoints.dart';
import 'package:mailapp01/api/api_helpers.dart';
import 'package:mailapp01/services/users/profile_body.dart';
import 'package:mailapp01/services/users/setting_body.dart';
import 'package:mailapp01/utils/shared_preferences_utils.dart';

class UserService {
  static Future<Map<String, dynamic>> updateUser(
    ProfileBody profileBody,
  ) async {
    final response = await ApiHelper.post(
      ApiEndpoints().profileUpdate,
      profileBody.bodyData(),
      ApiHelper.authRequestHeaders(),
    );

    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      String userInfoEncoded = jsonEncode({
        "name": result["data"]["user"]["name"],
        "phone": result["data"]["user"]["phone"],
        "email": result["data"]["user"]["email"],
        "push": result["data"]["user"]["push_notification"],
        "sms": result["data"]["user"]["sms_notification"],
        "is_verified": result["data"]["user"]["is_verified"] ?? 0,
      });
      await SharedPreferencesUtils.addStringToSF(
        "userInfo",
        userInfoEncoded,
      );
      return result;
    }
    return {
      "success": false,
      "message": "Error in updating data!",
    };
  }

  static Future<Map<String, dynamic>> updateUserSettings(
    SettingBody settingBody,
  ) async {
    final response = await ApiHelper.post(
      ApiEndpoints().updateSetting,
      settingBody.bodyData(),
      ApiHelper.authRequestHeaders(),
    );

    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      String userInfoEncoded = jsonEncode({
        "name": result["data"]["user"]["name"],
        "phone": result["data"]["user"]["phone"],
        "email": result["data"]["user"]["email"],
        "push": result["data"]["user"]["push_notification"],
        "sms": result["data"]["user"]["sms_notification"],
        "is_verified": result["data"]["user"]["is_verified"] ?? 0,
      });
      await SharedPreferencesUtils.addStringToSF(
        "userInfo",
        userInfoEncoded,
      );
      return result;
    }
    return {
      "success": false,
      "message": "Error in updating settings!",
    };
  }
}
