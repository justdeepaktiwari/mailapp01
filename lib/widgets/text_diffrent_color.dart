import 'package:flutter/material.dart';
import 'package:mailapp01/utils/constants.dart';

class TextDiffrentColorWidget extends StatelessWidget {
  final String startText;
  final String endText;
  const TextDiffrentColorWidget({
    super.key,
    required this.startText,
    required this.endText,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: startText,
            style: const TextStyle(
              color: AppConstants.appColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: endText,
            style: const TextStyle(
              color: AppConstants.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
