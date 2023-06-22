import 'package:flutter/material.dart';
import 'package:mailapp01/screens/auth/signin_screen.dart';

// ignore: must_be_immutable
class ScreenManageUtils extends StatefulWidget {
  int selectIndex;
  List<Widget> widgetOptions;
  bool isLogeddin;

  ScreenManageUtils({
    super.key,
    required this.selectIndex,
    required this.widgetOptions,
    required this.isLogeddin,
  });

  @override
  State<ScreenManageUtils> createState() => _ScreenManageUtilsState();
}

class _ScreenManageUtilsState extends State<ScreenManageUtils> {
  @override
  Widget build(BuildContext context) {
    return widget.isLogeddin
        ? widget.widgetOptions[widget.selectIndex]
        : const SignInScreen();
  }
}
