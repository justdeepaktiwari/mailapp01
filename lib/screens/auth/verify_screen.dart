import 'package:flutter/material.dart';
import 'package:mailapp01/widgets/button.dart';

import '../../utils/constants.dart';

class VerifyPage extends StatelessWidget {
  const VerifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Prashu kumar sharma,",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        decoration: TextDecoration.none),
                  ),
                  Text(
                    "9155XXXXXX",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        decoration: TextDecoration.none),
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
          ButtonWidget(onPressed: () {}, buttonName: "Click to verify"),
        ],
      ),
    );
  }
}
