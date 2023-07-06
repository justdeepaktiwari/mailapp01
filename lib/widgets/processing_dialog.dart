import 'package:flutter/material.dart';
import 'package:mailapp01/utils/constants.dart';

class ProcessingDialog extends StatelessWidget {
  const ProcessingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppConstants.appColor,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: AppConstants.white),
            SizedBox(height: 10.0),
            Text(
              "Processing....",
              style: TextStyle(color: AppConstants.white),
            )
          ],
        ),
      ),
    );
  }
}
