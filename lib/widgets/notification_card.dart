import 'package:flutter/material.dart';
import 'package:mailapp01/utils/constants.dart';

class NotificationCardWidget extends StatelessWidget {
  final String complexName;
  final String mailInfo;
  final String timeNotification;

  const NotificationCardWidget({
    super.key,
    required this.complexName,
    required this.mailInfo,
    required this.timeNotification,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      color: AppConstants.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  complexName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.white,
                  ),
                ),
                const SizedBox(
                  height: 5,
                  width: 0,
                ),
                Text(
                  mailInfo,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.white,
                  ),
                ),
                const SizedBox(
                  height: 3,
                  width: 0,
                ),
                Text(
                  timeNotification,
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                    color: AppConstants.white,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.notifications_active,
              color: AppConstants.white,
            )
          ],
        ),
      ),
    );
  }
}
