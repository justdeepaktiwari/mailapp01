import 'package:flutter/material.dart';
import 'package:mailapp01/utils/constants.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppConstants.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.signal_wifi_off,
              size: 64,
              color: Colors.white,
            ),
            SizedBox(height: 16),
            Text(
              'No internet connection',
              style: TextStyle(
                fontSize: 20,
                color: AppConstants.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Please check your connection and try again.',
              style: TextStyle(
                color: AppConstants.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
