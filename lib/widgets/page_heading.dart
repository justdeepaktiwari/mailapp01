import 'package:flutter/material.dart';
import 'package:mailapp01/utils/constants.dart';

class PageHeadingWidget extends StatelessWidget {
  final String headingText;
  const PageHeadingWidget({
    super.key,
    required this.headingText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(9, 0, 0, 0),
      child: Text(
        headingText,
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppConstants.white,
        ),
      ),
    );
  }
}
