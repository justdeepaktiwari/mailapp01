import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mailapp01/services/notifications/local_notification_service.dart';
import 'package:mailapp01/utils/shared_preferences_utils.dart';

class MobileSettings {
  Future<void> getDeviceTokenToSendNotification() async {
    print(SharedPreferencesUtils.getStringValuesSF("deviceId"));
    if (SharedPreferencesUtils.getStringValuesSF("deviceId").isNotEmpty) return;

    final fcmToken = await FirebaseMessaging.instance.getToken();
    await SharedPreferencesUtils.addStringToSF(
      "deviceId",
      fcmToken.toString(),
    );
  }

  Future<void> permissionRequest() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  forGroundState() {
    FirebaseMessaging.onMessage.listen(
      (message) {
        if (message.notification != null) {
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );
  }

  terminatedState() {
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message != null) {}
      },
    );
  }

  backgroundNotTerminated() {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        LocalNotificationService.createanddisplaynotification(message);
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }
}
