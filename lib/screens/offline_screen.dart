import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mailapp01/utils/constants.dart';

class OfflineScreen extends StatefulWidget {
  const OfflineScreen({super.key});

  @override
  State<OfflineScreen> createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen> {
  String text1 = 'No internet connection';
  String text2 = 'Please check your network settings and try again.';

  bool isOnline = false;

  @override
  void initState() {
    super.initState();
    checkInternet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryColor,
      body: Container(
        color: Colors.black54,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                text1,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              GestureDetector(
                child: Text(
                  text2,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white54,
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  if (isOnline) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkInternet() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      isOnline = status == InternetConnectionStatus.connected;
      if (isOnline) {
        text1 = "Now you are online";
        text2 = "Click to go back";
        setState(() {});
      } else {
        text1 = 'No internet connection';
        text2 = 'Please check your network settings and try again.';
        setState(() {});
      }
    });
  }
}
