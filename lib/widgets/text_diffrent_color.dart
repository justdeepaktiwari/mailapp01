import 'package:flutter/material.dart';
import 'package:mailapp01/utils/constants.dart';

class TextDiffrentColorWidget extends StatelessWidget {
  final String startText;
  final String endText;
  final double? startFontSize;
  final double? endFontSize;

  const TextDiffrentColorWidget({
    super.key,
    required this.startText,
    required this.endText,
    this.startFontSize,
    this.endFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: startText,
            style: TextStyle(
              color: AppConstants.appColor,
              fontSize: startFontSize ?? 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: endText,
            style: TextStyle(
              color: AppConstants.white,
              fontSize: endFontSize ?? 10,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
