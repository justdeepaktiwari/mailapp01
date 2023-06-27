import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:mailapp01/utils/constants.dart';

class ToggleSwitch extends StatefulWidget {
  const ToggleSwitch({Key? key}) : super(key: key);

  @override
  State<ToggleSwitch> createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  @override
  Widget build(BuildContext context) {
    return LiteRollingSwitch(
      value: true,
      textOn: 'On',
      textOff: 'Off',
      width: 90,
      colorOn: AppConstants.appColor,
      colorOff: AppConstants.primaryColor,
      iconOn: Icons.done,
      iconOff: Icons.remove_circle_outline,
      textSize: 14.0,
      onChanged: (bool state) {
        //Use it to manage the different states
      },
      onTap: () {},
      onDoubleTap: () {},
      onSwipe: () {},
    );
  }
}
