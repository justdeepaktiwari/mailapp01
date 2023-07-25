import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mailapp01/screens/home_screen.dart';
import 'package:mailapp01/services/notifications/local_notification_service.dart';
import 'package:mailapp01/utils/shared_preferences_utils.dart';

class MobileSettings {
  BuildContext context;
  MobileSettings(this.context);

  Future<void> getDeviceTokenToSendNotification() async {
    if (SharedPreferencesUtils.getStringValuesSF("deviceId").isNotEmpty) return;

    final fcmToken = await FirebaseMessaging.instance.getToken();
    await SharedPreferencesUtils.addStringToSF(
      "deviceId",
      fcmToken.toString(),
    );
  }

  Future<void> permissionRequest() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  forGroundState(auth) {
    FirebaseMessaging.onMessage.listen(
      (message) {
        if (message.notification != null) {
          LocalNotificationService.createanddisplaynotification(message);
          auth.refreshTrue();
        }
      },
    );
  }

  terminatedState() {
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
      },
    );
  }

  backgroundNotTerminated(auth) {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        if (message.notification != null) {
          auth.refreshTrue();
        }
      },
    );
  }
}
