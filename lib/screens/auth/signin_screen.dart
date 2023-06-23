import 'package:flutter/material.dart';
import 'package:mailapp01/providers/auth_provider.dart';
import 'package:mailapp01/utils/constants.dart';
import 'package:mailapp01/widgets/textfields/email_field.dart';
import 'package:mailapp01/widgets/textfields/password_field.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return ListView(
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
                const EmailTextFieldWidget(),
                const SizedBox(
                  height: 50,
                  width: double.infinity,
                ),
                const PasswordTextFieldWidget(),
                const SizedBox(
                  height: 10,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5, 0, 0),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Forgot Password?",
                          style: TextStyle(
                            color: AppConstants.appColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: " click here",
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                  width: double.infinity,
                ),
                ElevatedButton(
                  onPressed: () {
                    auth.login();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size(double.infinity, 55),
                  ),
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                  width: double.infinity,
                ),
                Center(
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "New User?",
                          style: TextStyle(
                            color: AppConstants.appColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: " SIGN UP",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
