import 'dart:convert';

import 'package:mailapp01/api/api_endpoints.dart';
import 'package:mailapp01/api/api_helpers.dart';
import 'package:mailapp01/services/complex/complex_body.dart';

class ComplexService {
  static Future<Map<String, dynamic>> requestComplex(
    ComplexBody complexBody,
  ) async {
    final response = await ApiHelper.post(
      ApiEndpoints.complexRequest,
      complexBody.bodyData(),
      ApiHelper.authRequestHeaders(),
    );

    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return result;
    } else if (response.statusCode == 422) {
      return result;
    }
    return {
      "success": false,
      "message": "Error in request complex!",
    };
  }
}
