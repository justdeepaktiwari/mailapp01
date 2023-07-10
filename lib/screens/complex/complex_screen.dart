import 'package:flutter/material.dart';
import 'package:mailapp01/models/complexs.dart';
import 'package:mailapp01/services/complex/complex_services.dart';
import 'package:mailapp01/utils/constants.dart';
import 'package:mailapp01/widgets/complex_card.dart';
import 'package:mailapp01/widgets/page_heading.dart';

class ComplexsScreen extends StatefulWidget {
  const ComplexsScreen({super.key});

  @override
  State<ComplexsScreen> createState() => _ComplexsScreenState();
}

class _ComplexsScreenState extends State<ComplexsScreen> {
  List<ComplexList> listComplexs = [];
  bool isLoading = true;
  int listComplexsLength = 0;
  TextEditingController complexId = TextEditingController();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();

    listComplex();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      replacement: RefreshIndicator(
        onRefresh: listComplex,
        child: SafeArea(
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
                  final complex = listComplexs[index];
                  return listComplexsLength > 0
                      ? ComplexCardWidget(
                          complexName: complex.name,
                          timeNotification: complex.email,
                          deleteComplex: () {
                            final complexIdRemove = complex.id;

                            print(complexIdRemove);
                          },
                        )
                      : const Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Text(
                              "No Complex Found!",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                },
                initialItemCount: listComplexs.length,
              )
            ],
          ),
        ),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> listComplex() async {
    final response = await ComplexService.listComplex();
    setState(() {
      listComplexs = response;
      listComplexsLength = listComplexs.length;
      isLoading = false;
    });
  }
}
