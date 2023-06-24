import 'package:flutter/material.dart';
import 'package:mailapp01/providers/auth_provider.dart';
import 'package:mailapp01/utils/constants.dart';
import 'package:mailapp01/widgets/notification_card.dart';
import 'package:mailapp01/widgets/page_heading.dart';
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
  void initState() {
    super.initState();
    // fetchNotification();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
// PageHeadingWidget(headingText: "NOTIFICATIONS"),

    return SafeArea(
      child: CustomScrollView(
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
            initialItemCount: 50,
          )
        ],
      ),
    );
  }
}
