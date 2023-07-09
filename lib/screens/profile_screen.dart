import 'package:flutter/material.dart';
import 'package:mailapp01/providers/auth_provider.dart';
import 'package:mailapp01/screens/auth/signin_screen.dart';
import 'package:mailapp01/services/auth/auth_service.dart';
import 'package:mailapp01/widgets/page_heading.dart';
import 'package:mailapp01/widgets/processing_dialog.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';
import '../widgets/button.dart';
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
    final auth = Provider.of<AuthProvider>(context);
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const PageHeadingWidget(
              headingText: "PROFILE",
            ),
            actions: [
              IconButton(
                icon: const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: Icon(Icons.logout, size: 28),
                ),
                onPressed: () async {
                  _showRegistrationDialog();
                  final response = await AuthService.logoutUser();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                  if (response["success"] == true) {
                    auth.logout();
                    if (!auth.isLoggedIn) {
                      setState(() {});
                      showSuccessMessage(
                        response["data"]["message"] ?? "Error in logout",
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    }
                  } else {
                    setState(() {});
                    showErrorMessage(response["message"] ?? "Error in logout");
                  }
                },
              ),
            ],
            floating: true,
            pinned: true,
            snap: false,
            backgroundColor: AppConstants.primaryColor,
            elevation: 4,
            toolbarHeight: 80,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(
                  height: 80,
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
                          onPressed: () {},
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
          )
        ],
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
}
