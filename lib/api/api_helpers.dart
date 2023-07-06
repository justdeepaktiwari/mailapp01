import 'dart:convert';

import 'package:http/http.dart';
import 'package:mailapp01/api/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static Uri parsedUrl(String endPoint) {
    return Uri.parse(ApiEndpoints.baseUrl + endPoint);
  }

  static Map<String, String> requestHeaders() {
    return {
      'Content-Type': 'application/vnd.api+json',
      'Accept': 'application/vnd.api+json',
    };
  }

  static Future<Response> get(String endPoint) async {
    final url = parsedUrl(endPoint);
    return await http.get(url, headers: requestHeaders());
  }

  static Future<Response> post(
    String endPoint,
    Map<String, dynamic> body,
  ) async {
    final url = parsedUrl(endPoint);
    return await http.post(
      url,
      body: jsonEncode(body),
      headers: requestHeaders(),
    );
  }
}
