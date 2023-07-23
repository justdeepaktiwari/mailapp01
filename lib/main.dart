import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mailapp01/screens/splash_screen.dart';
import 'package:mailapp01/services/notifications/local_notification_service.dart';
import 'package:mailapp01/services/settings/settings_services.dart';
import 'package:mailapp01/utils/constants.dart';
import 'package:mailapp01/utils/shared_preferences_utils.dart';
import 'package:provider/provider.dart';
import 'package:mailapp01/providers/auth_provider.dart';

import 'firebase_options.dart';

Future<void> backgroundHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesUtils.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    final mobileSettings = MobileSettings(context);
    mobileSettings.permissionRequest();

    mobileSettings.getDeviceTokenToSendNotification();
    mobileSettings.forGroundState();
    mobileSettings.backgroundNotTerminated();
    mobileSettings.terminatedState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: "MailBx",
        theme: ThemeData(
          primarySwatch: AppConstants.appColorMaterial,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
