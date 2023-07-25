import 'package:flutter/material.dart';
import 'package:mailapp01/screens/auth/verifycode_screen.dart';
import 'package:mailapp01/services/auth/auth_service.dart';
import 'package:mailapp01/services/auth/verifycode_body.dart';
import 'package:mailapp01/utils/constants.dart';
import 'package:mailapp01/widgets/processing_dialog.dart';

import '../../widgets/button.dart';
import '../../widgets/text_field.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  TextEditingController phone = TextEditingController();

  bool _isValidNumber = false;
  String phoneError = "Enter valid phone number";

  @override
  Widget build(BuildContext context) {
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
                "Forget Password",
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
                    const Text(
                      "Phone Number",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Enter the Phone number associated with your account.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                      labelText: "Phone Number",
                      editingController: phone,
                      isPasswordType: false,
                      textInputType: TextInputType.phone,
                      errorText: _isValidNumber ? phoneError : null,
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
                      buttonName: "Send Code",
                      onPressed: () async {
                        _isValidNumber = phone.text.length != 13;

                        if (_isValidNumber) {
                          setState(() {});
                          return;
                        }

                        _showProcessingDialog();

                        final response = await AuthService.sendResetCode(
                          VerifyCodeBody(
                            phone.text,
                          ),
                        );

                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();

                        if (response["success"]) {
                          showSuccessMessage(
                            response["message"] ?? "Code sent successfully!",
                          );

                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerifyUserScreen(
                                isForVerification: false,
                              ),
                            ),
                          );
                        } else {
                          _isValidNumber = true;
                          phoneError = "Enter correct number";
                          showErrorMessage(response["message"] ?? "");
                          setState(() {});
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
}
