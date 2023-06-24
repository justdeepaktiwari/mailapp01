import 'package:flutter/material.dart';
// import 'package:mailapp01/screens/home_screen.dart';
import 'package:mailapp01/screens/splash_screen.dart';
import 'package:mailapp01/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:mailapp01/providers/auth_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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