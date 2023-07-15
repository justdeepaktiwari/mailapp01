import 'package:flutter/material.dart';
import 'package:mailapp01/providers/auth_provider.dart';
import 'package:mailapp01/services/complex/complex_services.dart';
import 'package:mailapp01/services/complex/join_body.dart';
import 'package:mailapp01/services/datetime/humandate_services.dart';
import 'package:mailapp01/services/notifications/notification_service.dart';
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
  List listNotification = [];

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    listNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    TextEditingController complexId = TextEditingController();
    if (auth.isRefresh) {
      auth.refreshFalse();
      isLoading = true;
      listNotifications();
    }
    return Visibility(
      visible: isLoading,
      replacement: RefreshIndicator(
        onRefresh: listNotifications,
        child: SafeArea(
          child: auth.complexCount! == 0
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
                      setState(() {
                        isLoading = true;
                        listNotifications();
                      });
                      return;
                    }
                    showErrorMessage(
                      response["message"] ?? "Error in joining complex!",
                    );
                  },
                )
              : (listNotification.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Text(
                          "No Notification Found!",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              final notification = listNotification[index];
                              return NotificationCardWidget(
                                complexName: notification.complexName,
                                title: notification.title,
                                mailInfo: notification.message,
                                timeNotification: DateToHuman.getTimeDifference(
                                  notification.date,
                                ),
                              );
                            },
                            childCount: listNotification
                                .length, // The number of items in the list
                          ),
                        ),
                      ],
                    )),
        ),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
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

  Future<void> listNotifications() async {
    final response = await NotificationService.listComplex();
    setState(() {
      listNotification = response;
      isLoading = false;
    });
  }
}
