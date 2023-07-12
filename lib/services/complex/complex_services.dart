import 'dart:convert';

import 'package:mailapp01/api/api_endpoints.dart';
import 'package:mailapp01/api/api_helpers.dart';
import 'package:mailapp01/models/complexs.dart';
import 'package:mailapp01/services/complex/join_body.dart';
import 'package:mailapp01/services/complex/remove_body.dart';
import 'package:mailapp01/services/complex/request_body.dart';

class ComplexService {
  static Future<Map<String, dynamic>> requestComplex(
    RequestComplexBody complexBody,
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

  static Future<List<ComplexList>> listComplex() async {
    final response = await ApiHelper.get(
      ApiEndpoints.listComplex,
      ApiHelper.authRequestHeaders(),
    );

    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final result = json["data"]["complexes"] as List<dynamic>;
      final complexs = result.map((e) {
        return ComplexList.fromMap(e);
      }).toList();

      return complexs;
    } else {
      return [];
    }
  }

  static Future<Map<String, dynamic>> joinComplex(
    JoinComplexBody joinComplexBody,
  ) async {
    final response = await ApiHelper.post(
      ApiEndpoints.joinComplex,
      joinComplexBody.bodyData(),
      ApiHelper.authRequestHeaders(),
    );

    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return result;
    } else {
      return result;
    }
  }

  static Future<Map<String, dynamic>> removeComplex(
    RemoveComplexBody removeComplexBody,
  ) async {
    final response = await ApiHelper.post(
      ApiEndpoints.removeComplex,
      removeComplexBody.bodyData(),
      ApiHelper.authRequestHeaders(),
    );

    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return result;
    } else {
      return result;
    }
  }
}
