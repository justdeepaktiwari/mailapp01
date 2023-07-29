import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mailapp01/screens/auth/signin_screen.dart';
import 'package:mailapp01/services/auth/auth_service.dart';
import 'package:mailapp01/services/auth/reset_body.dart';
import 'package:mailapp01/widgets/processing_dialog.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../utils/constants.dart';
import '../../widgets/button.dart';
import '../../widgets/text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();

  String? passwordError;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: AppConstants.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
              width: double.infinity,
            ),
            const Center(
              child: Text(
                "Reset Password",
                style: TextStyle(
                  fontSize: 40,
                  color: AppConstants.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 80,
              width: double.infinity,
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppConstants.appColor,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
              width: double.infinity,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                      labelText: "Enter new Password",
                      editingController: newPassword,
                      isPasswordType: true,
                      textInputType: TextInputType.visiblePassword,
                      errorText: passwordError,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                      labelText: "Confirm new Password",
                      editingController: confirmNewPassword,
                      isPasswordType: true,
                      textInputType: TextInputType.visiblePassword,
                      errorText: passwordError,
                    ),
                    const SizedBox(
                      height: 10,
                      width: double.infinity,
                    ),
                    const SizedBox(
                      height: 20,
                      width: double.infinity,
                    ),
                    ButtonWidget(
                      buttonName: "Continue",
                      onPressed: () async {
                        if (newPassword.text.length < 6) {
                          passwordError = "Password should be 6 digit";
                          setState(() {});
                          return;
                        } else if (newPassword.text !=
                            confirmNewPassword.text) {
                          passwordError = "Password and Confirm should be same";
                          setState(() {});
                          return;
                        } else {
                          passwordError = null;
                          setState(() {});
                        }
                        _showProcessingDialog();
                        final response = await AuthService.resetPassword(
                          ResetPasswordBody(
                            auth.resetCode ?? "",
                            auth.resetPhoneNumber ?? "",
                            newPassword.text,
                          ),
                        );
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                        if (response["success"] ?? false) {
                          showSuccessMessage(
                            response["message"] ??
                                "Successfully password reset",
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInScreen(),
                            ),
                          );
                        } else {
                          showErrorMessage(
                            response["message"] ?? "Error in reset password",
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 50,
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
    newPassword.dispose();
    confirmNewPassword.dispose();
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
