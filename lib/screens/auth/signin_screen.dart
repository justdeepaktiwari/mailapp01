import 'package:flutter/material.dart';
import 'package:mailapp01/providers/auth_provider.dart';
import 'package:mailapp01/utils/constants.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return ListView(
      children: [
        const SizedBox(
          height: 100,
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
          height: 100,
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
          height: 0,
          width: double.infinity,
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppConstants.appColor,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppConstants.appColor,
                      width: 2.0,
                    ),
                  ),
                  hintText: "E-Mail",
                  hintStyle: const TextStyle(
                    fontSize: 20.0,
                    color: AppConstants.appColor,
                    fontWeight: FontWeight.bold,
                  ),
                  contentPadding: EdgeInsets.all(15),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
              )
            ],
          ),
        )
      ],
    );

    // Center(
    //   child: ElevatedButton(
    //     onPressed: () {
    //       auth.login();
    //     },
    //     child: const Text("Sign In"),
    //   ),
    // );
  }
}
