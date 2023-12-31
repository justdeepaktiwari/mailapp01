import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mailapp01/providers/auth_provider.dart';
import 'package:mailapp01/screens/auth/signin_screen.dart';
import 'package:mailapp01/screens/auth/verify_screen.dart';
import 'package:mailapp01/screens/home_screen.dart';
import 'package:mailapp01/utils/constants.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.checkLoggin();

    navigate(authProvider);
  }

  void navigate(authProvider) async {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => authProvider.isLoggedIn
              ? (authProvider.isVerified
                  ? const HomeScreen()
                  : const VerifyPage())
              : const SignInScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryColor,
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/applogo.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          height: 77,
          width: 248,
        ),
      ),
    );
  }
}
