import 'package:flutter/material.dart';
import 'package:mailapp01/providers/auth_provider.dart';
import 'package:mailapp01/services/users/setting_body.dart';
import 'package:mailapp01/services/users/user_service.dart';
import 'package:mailapp01/widgets/processing_dialog.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';
import '../widgets/page_heading.dart';
import '../widgets/toggle_switch.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<AuthProvider>(context);
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: PageHeadingWidget(
            headingText: "SETTINGS",
          ),
          floating: true,
          pinned: true,
          snap: false,
          backgroundColor: AppConstants.primaryColor,
          elevation: 4,
          toolbarHeight: 80,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 20.0,
                ),
                height: 75,
                color: AppConstants.cardColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Notification By SMS",
                      style: TextStyle(
                        color: AppConstants.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ToggleSwitch(
                      onChange: (bool state) async {
                        _showProcessingDialog();

                        final response = await UserService.updateUserSettings(
                          SettingBody(
                            sms: state ? 1 : 0,
                            push: null,
                          ),
                        );

                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                        if (response["success"] ?? false) {
                          userInfo.checkLoggin();
                          showSuccessMessage(
                            response["message"] ??
                                "Notification Setting Updated",
                          );
                          setState(() {});
                          return;
                        }
                        showErrorMessage(
                          response["message"] ?? "Notification Setting Updated",
                        );
                      },
                      isOn: userInfo.userInfo["sms"] == 1 ? true : false,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 20.0,
                ),
                height: 75,
                color: AppConstants.cardColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Notification By MailBx",
                      style: TextStyle(
                        color: AppConstants.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ToggleSwitch(
                      onChange: (bool state) async {
                        _showProcessingDialog();
                        final response = await UserService.updateUserSettings(
                          SettingBody(
                            sms: null,
                            push: state ? 1 : 0,
                          ),
                        );
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                        if (response["success"] ?? false) {
                          userInfo.checkLoggin();
                          showSuccessMessage(
                            response["message"] ??
                                "Notification Setting Updated",
                          );
                          setState(() {});
                          return;
                        }
                        showErrorMessage(
                          response["message"] ?? "Notification Setting Updated",
                        );
                      },
                      isOn: userInfo.userInfo["push"] == 1 ? true : false,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
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

  @override
  void dispose() {
    super.dispose();
  }
}
