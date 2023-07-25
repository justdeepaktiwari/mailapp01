import 'dart:convert';

import 'package:mailapp01/api/api_endpoints.dart';
import 'package:mailapp01/api/api_helpers.dart';
import 'package:mailapp01/services/auth/login_body.dart';
import 'package:mailapp01/services/auth/register_body.dart';
import 'package:mailapp01/services/auth/reset_body.dart';
import 'package:mailapp01/services/auth/verify_body.dart';
import 'package:mailapp01/services/auth/verifycode_body.dart';
import 'package:mailapp01/utils/shared_preferences_utils.dart';

class AuthService {
  static Future<Map<String, dynamic>> registerUser(
    RegisterBody registerBody,
  ) async {
    final response = await ApiHelper.post(
      ApiEndpoints().register,
      registerBody.bodyData(),
      ApiHelper.guestRequestHeaders(),
    );

    final result = jsonDecode(response.body);

    if (response.statusCode == 200) {
      await SharedPreferencesUtils.addStringToSF(
        "token",
        result["data"]["token"]["plainTextToken"],
      );
      await SharedPreferencesUtils.addIntToSF(
        "complexCount",
        result["data"]["complex_count"] ?? 0,
      );
      if (result["data"]["token"]["plainTextToken"] != null) {
        await SharedPreferencesUtils.addBoolToSF("isLoggedin", true);
        await SharedPreferencesUtils.addIntToSF(
          "userId",
          result["data"]["user"]["id"],
        );
        String userInfoEncoded = jsonEncode({
          "name": result["data"]["user"]["name"],
          "phone": result["data"]["user"]["phone"],
          "email": result["data"]["user"]["email"],
          "push": result["data"]["user"]["push_notification"],
          "sms": result["data"]["user"]["sms_notification"],
          "is_verified": result["data"]["user"]["is_verified"],
        });
        await SharedPreferencesUtils.addStringToSF(
          "userInfo",
          userInfoEncoded,
        );
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
      ApiEndpoints().login,
      loginBody.bodyData(),
      ApiHelper.guestRequestHeaders(),
    );

    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      await SharedPreferencesUtils.addStringToSF(
        "token",
        result["data"]["token"]["plainTextToken"],
      );
      await SharedPreferencesUtils.addIntToSF(
        "complexCount",
        result["data"]["complex_count"] ?? 0,
      );
      if (result["data"]["token"]["plainTextToken"] != null) {
        await SharedPreferencesUtils.addBoolToSF("isLoggedin", true);
        await SharedPreferencesUtils.addIntToSF(
          "userId",
          result["data"]["user"]["id"],
        );
        String userInfoEncoded = jsonEncode({
          "name": result["data"]["user"]["name"],
          "phone": result["data"]["user"]["phone"],
          "email": result["data"]["user"]["email"],
          "push": result["data"]["user"]["push_notification"],
          "sms": result["data"]["user"]["sms_notification"],
          "is_verified": result["data"]["user"]["is_verified"],
        });
        await SharedPreferencesUtils.addStringToSF(
          "userInfo",
          userInfoEncoded,
        );
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

  static Future<Map<String, dynamic>> verifyUser(VerifyBody verifyBody) async {
    final response = await ApiHelper.post(
      ApiEndpoints().verifyUser,
      verifyBody.bodyData(),
      ApiHelper.authRequestHeaders(),
    );

    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final decodedInfo = jsonDecode(
        SharedPreferencesUtils.getStringValuesSF("userInfo"),
      );
      decodedInfo["is_verified"] = 1;

      String userInfoEncoded = jsonEncode(decodedInfo);
      await SharedPreferencesUtils.addStringToSF(
        "userInfo",
        userInfoEncoded,
      );

      return result;
    }

    return {
      "success": false,
      "message": "Error encounter try again!",
    };
  }

  static Future<Map<String, dynamic>> sendVerifyCode(
    VerifyCodeBody verifyCodeBody,
  ) async {
    final response = await ApiHelper.post(
      ApiEndpoints().sendVerifyCode,
      verifyCodeBody.bodyData(),
      ApiHelper.authRequestHeaders(),
    );

    final result = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return result;
    }

    return {
      "success": false,
      "message": "Error in sending code!",
    };
  }

  static Future<Map<String, dynamic>> sendResetCode(
    VerifyCodeBody resetCodeBody,
  ) async {
    final response = await ApiHelper.post(
      ApiEndpoints().resetRequestCode,
      resetCodeBody.bodyData(),
      ApiHelper.guestRequestHeaders(),
    );

    final result = jsonDecode(response.body);

    if (response.statusCode == 200) {
      await SharedPreferencesUtils.addStringToSF(
        "resetPhone",
        resetCodeBody.phoneNumber,
      );
      return result;
    }

    return {
      "success": false,
      "message": "Error in sending code!",
    };
  }

  static Future<Map<String, dynamic>> verifyResetCode(
    VerifyBody resetCodeBody,
  ) async {
    final response = await ApiHelper.post(
      ApiEndpoints().passwordResetVerify,
      resetCodeBody.bodyData(),
      ApiHelper.guestRequestHeaders(),
    );

    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      await SharedPreferencesUtils.addStringToSF(
        "resetCode",
        resetCodeBody.code,
      );
      return result;
    } else if (response.statusCode == 400) {
      return result;
    }
    return {
      "success": false,
      "message": "Error in verifying code!",
    };
  }

  static Future<Map<String, dynamic>> resetPassword(
    ResetPasswordBody resetPasswordBody,
  ) async {
    final response = await ApiHelper.post(
      ApiEndpoints().passwordReset,
      resetPasswordBody.bodyData(),
      ApiHelper.guestRequestHeaders(),
    );

    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return result;
    }

    return {
      "success": false,
      "message": "Error in sending code!",
    };
  }

  static Future<Map<String, dynamic>> logoutUser() async {
    final response = await ApiHelper.post(
      ApiEndpoints().logout,
      {},
      ApiHelper.authRequestHeaders(),
    );
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      SharedPreferencesUtils.removeValue([
        "isLoggedin",
        "token",
        "userId",
        "userInfo",
        "complexCount",
        "isVerified",
      ]);
      return result;
    } else {
      if (SharedPreferencesUtils.removeValue([
        "isLoggedin",
        "token",
        "userId",
        "userInfo",
        "complexCount",
        "isVerified",
      ])) {
        return {"success": true, "message": "Logout successfully!"};
      }
      return {"success": true, "message": "Logout successfully!"};
    }
  }
}
