import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:mailapp01/utils/constants.dart';

// ignore: must_be_immutable
class ToggleSwitch extends StatefulWidget {
  Function(bool state) onChange;
  bool isOn;

  ToggleSwitch({
    Key? key,
    required this.onChange,
    required this.isOn,
  }) : super(key: key);

  @override
  State<ToggleSwitch> createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  @override
  Widget build(BuildContext context) {
    return LiteRollingSwitch(
      value: widget.isOn,
      textOn: 'On',
      textOff: 'Off',
      width: 90,
      colorOn: AppConstants.appColor,
      colorOff: AppConstants.primaryColor,
      iconOn: Icons.done,
      iconOff: Icons.remove_circle_outline,
      textSize: 14.0,
      onChanged: widget.onChange,
      onTap: () {},
      onDoubleTap: () {},
      onSwipe: () {},
    );
  }
}
