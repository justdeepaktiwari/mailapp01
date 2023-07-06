import 'package:flutter/material.dart';
import 'package:mailapp01/providers/auth_provider.dart';
import 'package:mailapp01/screens/auth/signup_screen.dart';
import 'package:mailapp01/screens/home_screen.dart';
import 'package:mailapp01/utils/constants.dart';
import 'package:mailapp01/widgets/button.dart';
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
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();

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
                        auth.login();
                        if (auth.isLoggedIn) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
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
}
