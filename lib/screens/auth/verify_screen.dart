import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mailapp01/providers/auth_provider.dart';
import 'package:mailapp01/screens/auth/signin_screen.dart';
import 'package:mailapp01/screens/auth/verifycode_screen.dart';
import 'package:mailapp01/services/auth/auth_service.dart';
import 'package:mailapp01/services/auth/verifycode_body.dart';
import 'package:mailapp01/widgets/button.dart';
import 'package:mailapp01/widgets/processing_dialog.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppConstants.primaryColor,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.message_outlined,
                color: Colors.white,
                size: 80.0,
              ),
              const SizedBox(
                height: 30.0,
              ),
              const Text(
                "Please verify your account.",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Prashu kumar sharma,",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Text(
                        auth.userInfo["phone"],
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "Click on the below button and we will send an OTP to the registered number to verify your account.",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              const SizedBox(
                height: 30.0,
              ),
              ButtonWidget(
                onPressed: () async {
                  _showProcessingDialog();
                  if (auth.userInfo["phone"] != "") {
                    final response = await AuthService.sendVerifyCode(
                      VerifyCodeBody(auth.userInfo["phone"]),
                    );

                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();

                    if (response["success"]) {
                      showSuccessMessage(
                        response["message"] ?? "Successfully Code Sent",
                      );

                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VerifyUserScreen(),
                        ),
                      );
                    } else {
                      showErrorMessage(
                        response["message"] ?? "Error in sending code",
                      );
                    }
                  } else {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                    );
                  }
                },
                buttonName: "Click to verify",
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppConstants.primaryColor,
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void _showProcessingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const ProcessingDialog();
      },
    );
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  getConnectivity() async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (!isDeviceConnected && isAlertSet == false) {
      showDialogBox();
      setState(() => isAlertSet = true);
    }

    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() => isAlertSet = true);
        }
      },
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
