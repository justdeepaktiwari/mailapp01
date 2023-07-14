import 'dart:convert';

import 'package:mailapp01/api/api_endpoints.dart';
import 'package:mailapp01/api/api_helpers.dart';
import 'package:mailapp01/models/notifications.dart';

class NotificationService {
  static Future<List<NotificationList>> listComplex() async {
    final response = await ApiHelper.get(
      ApiEndpoints().listNotifications,
      ApiHelper.authRequestHeaders(),
    );

    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final result = json["data"]["notifications"] as List<dynamic>;
      final notifications = result.map((e) {
        return NotificationList.fromMap(e);
      }).toList();

      return notifications;
    } else {
      return [];
    }
  }
}
