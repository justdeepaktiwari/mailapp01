import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../widgets/button.dart';
import '../widgets/text_field.dart';
import '../widgets/text_field_with_icon.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Profile",
            style: TextStyle(
              fontSize: 40,
              color: AppConstants.white,
              fontWeight: FontWeight.bold,
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
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFieldIconWidget(
                    labelText: "Full Name",
                    editingController: name,
                    isPasswordType: false,
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 20,
                    width: double.infinity,
                  ),
                  TextFieldIconWidget(
                    labelText: "Phone Number",
                    editingController: phone,
                    isPasswordType: false,
                    textInputType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 20,
                    width: double.infinity,
                  ),
                  TextFieldIconWidget(
                    labelText: "E-mail Address",
                    editingController: emailAddress,
                    isPasswordType: false,
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 20,
                    width: double.infinity,
                  ),
                  TextFieldIconWidget(
                    labelText: "Password",
                    editingController: password,
                    isPasswordType: true,
                    textInputType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(
                    height: 20,
                    width: double.infinity,
                  ),
                  ButtonWidget(
                      buttonName: "Save",
                      onPressed: () {
                       
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
    );
  }
}
