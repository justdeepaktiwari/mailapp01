import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mailapp01/providers/auth_provider.dart';
import 'package:mailapp01/screens/auth/verify_screen.dart';
import 'package:mailapp01/screens/auth/signup_screen.dart';
import 'package:mailapp01/screens/home_screen.dart';
import 'package:mailapp01/services/auth/auth_service.dart';
import 'package:mailapp01/services/auth/login_body.dart';
import 'package:mailapp01/utils/constants.dart';
import 'package:mailapp01/widgets/button.dart';
import 'package:mailapp01/widgets/processing_dialog.dart';
import 'package:mailapp01/widgets/text_diffrent_color.dart';
import 'package:mailapp01/widgets/text_field.dart';
import 'package:provider/provider.dart';

import 'forget_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  bool _isValidEmail = false;
  bool _isValidPassword = false;

  String passwordError = "Enter valid valid password";
  String emailError = "Enter valid Email";

  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    getConnectivity();
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    navigate(authProvider.isLoggedIn, authProvider.isVerified);
  }

  void navigate(isLoggedIn, isVerified) {
    if (isLoggedIn && !isVerified) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              isVerified ? const HomeScreen() : const VerifyPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 80,
              width: double.infinity,
            ),
            const Center(
              child: Text(
                "Sign In",
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
                    TextFieldWidget(
                      labelText: "Email Adress",
                      editingController: emailAddress,
                      isPasswordType: false,
                      textInputType: TextInputType.emailAddress,
                      errorText: _isValidEmail ? emailError : null,
                    ),
                    const SizedBox(
                      height: 20,
                      width: double.infinity,
                    ),
                    TextFieldWidget(
                      labelText: "Password",
                      editingController: password,
                      isPasswordType: true,
                      textInputType: TextInputType.visiblePassword,
                      errorText: _isValidPassword ? passwordError : null,
                      minLines: null,
                      maxLines: null,
                    ),
                    const SizedBox(
                      height: 10,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 5, 0, 0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgetScreen(),
                            ),
                          );
                        },
                        child: const TextDiffrentColorWidget(
                          startText: "Forgot Password?",
                          endText: " click here",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                      width: double.infinity,
                    ),
                    ButtonWidget(
                      buttonName: "Sign In",
                      onPressed: () async {
                        _isValidEmail = !EmailValidator.validate(
                          emailAddress.text,
                        );
                        emailError = "Enter valid Email";

                        _isValidPassword = password.text.length < 6;
                        passwordError = "Enter valid password";

                        if (_isValidEmail || _isValidPassword) {
                          setState(() {});
                          return;
                        }

                        _showProcessingDialog();

                        final response = await AuthService.loginUser(
                          LoginBody(
                            emailAddress.text,
                            password.text,
                            auth.deviceId ?? "waiting",
                          ),
                        );

                        if (response["success"]) {
                          auth.checkLoggin();
                          showSuccessMessage(
                            response["message"] ?? "Login Successfully!",
                          );
                        } else {
                          _isValidPassword = true;
                          passwordError = "Enter correct credentials";

                          _isValidEmail = true;
                          emailError = "Enter correct credentials";
                          showErrorMessage(response["message"] ?? "");
                          setState(() {});
                        }

                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();

                        if (auth.isLoggedIn) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => auth.isVerified
                                  ? const HomeScreen()
                                  : const VerifyPage(),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 50,
                      width: double.infinity,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: const TextDiffrentColorWidget(
                          startText: "New User?",
                          endText: " SIGN UP",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppConstants.primaryColor,
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

  @override
  void dispose() {
    subscription.cancel();
    emailAddress.dispose();
    password.dispose();
    super.dispose();
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
