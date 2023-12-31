import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mailapp01/providers/auth_provider.dart';
import 'package:mailapp01/screens/auth/signin_screen.dart';
import 'package:mailapp01/screens/auth/verify_screen.dart';
import 'package:mailapp01/screens/home_screen.dart';
import 'package:mailapp01/services/auth/auth_service.dart';
import 'package:mailapp01/services/auth/register_body.dart';
import 'package:mailapp01/utils/constants.dart';
import 'package:mailapp01/widgets/processing_dialog.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

import '../../widgets/button.dart';
import '../../widgets/text_diffrent_color.dart';
import '../../widgets/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  bool _isValidEmail = false;
  bool _isValidPhone = false;
  bool _isValidPassword = false;
  bool _isValidCnfPassword = false;
  bool _isValidName = false;

  String phoneError = "Enter valid phone number";
  String emailError = "Enter valid Email";

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  void initState() {
    getConnectivity();
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.checkLoggin();
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
      backgroundColor: AppConstants.primaryColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 70,
              width: double.infinity,
            ),
            const Center(
              child: Text(
                "Register Yourself",
                style: TextStyle(
                  fontSize: 40,
                  color: AppConstants.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 50,
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
              height: 30,
              width: double.infinity,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldWidget(
                      labelText: "Full Name",
                      editingController: name,
                      isPasswordType: false,
                      textInputType: TextInputType.text,
                      errorText: _isValidName ? "Enter a valid name" : null,
                    ),
                    const SizedBox(
                      height: 20,
                      width: double.infinity,
                    ),
                    TextFieldWidget(
                      labelText: "Phone Number",
                      editingController: phone,
                      isPasswordType: false,
                      textInputType: TextInputType.phone,
                      errorText: _isValidPhone ? phoneError : null,
                    ),
                    const SizedBox(
                      height: 20,
                      width: double.infinity,
                    ),
                    TextFieldWidget(
                      labelText: "E-mail Address",
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
                      errorText:
                          _isValidPassword ? "Enter at least 6 digit" : null,
                    ),
                    const SizedBox(
                      height: 20,
                      width: double.infinity,
                    ),
                    TextFieldWidget(
                      labelText: "Confirm Password",
                      editingController: confirmPassword,
                      isPasswordType: true,
                      textInputType: TextInputType.visiblePassword,
                      errorText: _isValidCnfPassword
                          ? "Password doesn't matched"
                          : null,
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
                      buttonName: "Sign Up",
                      onPressed: () async {
                        _isValidEmail = !EmailValidator.validate(
                          emailAddress.text,
                        );
                        phoneError = "Enter valid phone number";
                        emailError = "Enter valid Email";

                        _isValidPassword = password.text.length < 6;
                        _isValidCnfPassword =
                            password.text != confirmPassword.text;

                        var replacedText = phone.text.replaceAll(RegExp('[^0-9]'), '');
                        _isValidPhone = replacedText.length != 10;

                        _isValidName = name.text == '';

                        bool fieldCheck = _isValidEmail ||
                            _isValidPassword ||
                            _isValidCnfPassword ||
                            _isValidPhone ||
                            _isValidName;

                        if (fieldCheck) {
                          setState(() {});
                          return;
                        }
                        _showRegistrationDialog();

                        final response = await AuthService.registerUser(
                          RegisterBody(
                            name.text,
                            emailAddress.text,
                            "+91${phone.text}",
                            password.text,
                            confirmPassword.text,
                            auth.deviceId ?? "waiting",
                          ),
                        );

                        if (response["success"] ?? false) {
                          auth.checkLoggin();
                          showSuccessMessage(response["message"] ??
                              "Created Account Successfully!");
                        } else {
                          setState(() {
                            if (response["errors"]["email"] != null) {
                              _isValidEmail = true;
                              emailError = response["errors"]["email"][0];
                            }

                            if (response["errors"]["phone"] != null) {
                              _isValidPhone = true;
                              phoneError = response["errors"]["phone"][0];
                            }
                          });
                          showErrorMessage(response["message"] ?? "");
                        }

                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();

                        if (auth.isLoggedIn) {
                          // ignore: use_build_context_synchronously
                          navigate(auth.isLoggedIn, auth.isVerified);
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
                              builder: (context) => const SignInScreen(),
                            ),
                          );
                        },
                        child: const TextDiffrentColorWidget(
                          startText: "Already a User?",
                          endText: " SIGN IN",
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
    );
  }

  void _showRegistrationDialog() {
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
    name.dispose();
    phone.dispose();
    emailAddress.dispose();
    password.dispose();
    confirmPassword.dispose();
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
