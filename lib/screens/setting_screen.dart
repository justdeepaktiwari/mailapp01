import 'package:flutter/material.dart';

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
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                height: 75,
                color: AppConstants.cardColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Notification By SMS",
                      style: TextStyle(
                          color: AppConstants.appColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    ToggleSwitch()
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                height: 75,
                color: AppConstants.cardColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Notification By Mailbx",
                      style: TextStyle(
                          color: AppConstants.appColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    ToggleSwitch()
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
