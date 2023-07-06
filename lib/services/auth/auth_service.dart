import 'package:mailapp01/api/api_endpoints.dart';
import 'package:mailapp01/api/api_helpers.dart';
import 'package:mailapp01/providers/auth_provider.dart';
import 'package:mailapp01/services/auth/login_body.dart';
import 'package:mailapp01/services/auth/register_body.dart';
import 'package:mailapp01/utils/shared_preferences_utils.dart';
import 'package:provider/provider.dart';

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
    );

    if (response.statusCode == 200) {
      await SharedPreferencesUtils.addBoolToSF("isLoggedin", true);
      return {
        "success": true,
        "messsage": "User Registered Sucess!",
      };
    } else if (response.statusCode == 422) {
      return {
        "success": true,
        "messsage": "User Registered Sucess!",
      };
    }

    return {
      "success": false,
      "messsage": "Error encountry try again!",
    };
  }

  static Future<void> loginUser(LoginBody loginBody) async {
    final response = await ApiHelper.post(
      ApiEndpoints.login,
      loginBody.bodyData(),
    );
  }

  static Future<void> logoutUser(String token) async {
    final body = {"token": token};
    final response = await ApiHelper.post(ApiEndpoints.logout, body);
  }
}
