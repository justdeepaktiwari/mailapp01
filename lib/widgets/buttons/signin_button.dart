import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SignInButtonWidget extends StatelessWidget {
  Future<void> login;
  SignInButtonWidget({super.key, required this.login});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
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
    );
  }
}
