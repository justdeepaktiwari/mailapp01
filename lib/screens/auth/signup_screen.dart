import 'package:flutter/material.dart';
import 'package:mailapp01/providers/auth_provider.dart';
import 'package:mailapp01/screens/auth/signin_screen.dart';
import 'package:mailapp01/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../widgets/button.dart';
import '../../widgets/text_diffrent_color.dart';
import '../../widgets/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
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
                "Sign Up",
                style: TextStyle(
                  fontSize: 40,
                  color: AppConstants.appColor,
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
                      labelText: "Full Name",
                      editingController: name,
                      isPasswordType: false,
                      textInputType: TextInputType.text,
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
                      buttonName: "Sign In",
                      onPressed: () {
                        auth.login();
                      },
                    ),
                    const SizedBox(
                      height: 50,
                      width: double.infinity,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
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
}
