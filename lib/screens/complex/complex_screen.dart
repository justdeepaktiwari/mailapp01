import 'package:flutter/material.dart';
import 'package:mailapp01/utils/constants.dart';
import 'package:mailapp01/widgets/complex_card.dart';
import 'package:mailapp01/widgets/page_heading.dart';

class ComplexsScreen extends StatefulWidget {
  const ComplexsScreen({super.key});

  @override
  State<ComplexsScreen> createState() => _ComplexsScreenState();
}

class _ComplexsScreenState extends State<ComplexsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: PageHeadingWidget(
              headingText: "COMPLEXES",
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
              return ComplexCardWidget(
                complexName: "ComplexName",
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
