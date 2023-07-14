import 'dart:convert';

import 'package:http/http.dart';
import 'package:mailapp01/api/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:mailapp01/utils/shared_preferences_utils.dart';

class ApiHelper {
  static Uri parsedUrl(String endPoint) {
    return Uri.parse(ApiEndpoints().baseUrl + endPoint);
  }

  static Map<String, String> guestRequestHeaders() {
    return {
      'Content-Type': 'application/vnd.api+json',
      'Accept': 'application/vnd.api+json',
    };
  }

  static Map<String, String> authRequestHeaders() {
    final String token = SharedPreferencesUtils.getStringValuesSF("token");
    return {
      'Content-Type': 'application/vnd.api+json',
      'Accept': 'application/vnd.api+json',
      'Authorization': 'Bearer $token',
    };
  }

  static Future<Response> get(
      String endPoint, Map<String, String> requestHeader) async {
    final url = parsedUrl(endPoint);
    return await http.get(url, headers: requestHeader);
  }

  static Future<Response> post(
    String endPoint,
    Map<String, dynamic> body,
    Map<String, String> requestHeader,
  ) async {
    final url = parsedUrl(endPoint);
    return await http.post(
      url,
      body: body.isNotEmpty ? jsonEncode(body) : null,
      headers: requestHeader,
    );
  }
}
