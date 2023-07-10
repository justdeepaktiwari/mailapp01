import 'package:flutter/material.dart';
import 'package:mailapp01/providers/auth_provider.dart';
import 'package:mailapp01/services/complex/complex_services.dart';
import 'package:mailapp01/services/complex/join_body.dart';
import 'package:mailapp01/utils/constants.dart';
import 'package:mailapp01/widgets/notification_card.dart';
import 'package:mailapp01/widgets/page_heading.dart';
import 'package:mailapp01/widgets/processing_dialog.dart';
import 'package:mailapp01/widgets/requestcard_complex.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool isLoading = true;
  List items = [];

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    TextEditingController complexId = TextEditingController();

    return SafeArea(
      child: items.isEmpty
          ? RequestComplexCardWidget(
              complexId: complexId,
              onTap: () async {
                if (complexId.text == '') {
                  return;
                }

                _showProcessingDialog();
                final response = await ComplexService.joinComplex(
                  JoinComplexBody(
                    complexCode: complexId.text,
                    userId: auth.userId.toString(),
                  ),
                );

                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();

                if (response["success"]) {
                  auth.checkLoggin();
                  showSuccessMessage(
                    response["message"] ?? "You joined complex!",
                  );
                  setState(() {});
                  return;
                }
                showErrorMessage(
                  response["message"] ?? "Error in joining complex!",
                );
              },
            )
          : CustomScrollView(
              slivers: [
                const SliverAppBar(
                  title: PageHeadingWidget(
                    headingText: "NOTIFICATIONS",
                  ),
                  floating: true,
                  pinned: true,
                  snap: false,
                  backgroundColor: AppConstants.primaryColor,
                  elevation: 4,
                  toolbarHeight: 80,
                ),
                SliverAnimatedList(
                  itemBuilder: (context, index, animation) {
                    return NotificationCardWidget(
                      complexName: "Complex $index",
                      mailInfo: "Mail is here",
                      timeNotification: "1$index min ago",
                    );
                  },
                  initialItemCount: items.length,
                )
              ],
            ),
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
}
