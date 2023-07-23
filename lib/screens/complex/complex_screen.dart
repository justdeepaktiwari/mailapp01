import 'package:flutter/material.dart';
import 'package:mailapp01/models/complexs.dart';
import 'package:mailapp01/providers/auth_provider.dart';
import 'package:mailapp01/services/complex/complex_services.dart';
import 'package:mailapp01/services/complex/remove_body.dart';
import 'package:mailapp01/utils/constants.dart';
import 'package:mailapp01/widgets/complex_card.dart';
import 'package:mailapp01/widgets/page_heading.dart';
import 'package:mailapp01/widgets/processing_dialog.dart';
import 'package:provider/provider.dart';

class ComplexsScreen extends StatefulWidget {
  const ComplexsScreen({super.key});

  @override
  State<ComplexsScreen> createState() => _ComplexsScreenState();
}

class _ComplexsScreenState extends State<ComplexsScreen> {
  List<ComplexList> listComplexs = [];
  bool isLoading = true;
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
    final auth = Provider.of<AuthProvider>(context);
    if (auth.isRefresh) {
      auth.refreshFalse();
      isLoading = true;
      listComplex();
    }
    return Visibility(
      visible: isLoading,
      replacement: RefreshIndicator(
        onRefresh: listComplex,
        child: listComplexs.isEmpty
            ? const Center(
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
              )
            : SafeArea(
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
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final complex = listComplexs[index];
                          return ComplexCardWidget(
                            complexName: complex.name,
                            timeNotification: complex.email,
                            deleteComplex: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext dialogueContext) {
                                  return AlertDialog(
                                    backgroundColor: AppConstants.primaryColor,
                                    title: const Text(
                                      'Confirmation',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    content: const Text(
                                      'Are you sure you want to proceed?',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text(
                                          'Yes',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        onPressed: () async {
                                          // Call your function to proceed here.
                                          Navigator.of(dialogueContext).pop();
                                          _showProcessingDialog();
                                          final response = await ComplexService
                                              .removeComplex(
                                            RemoveComplexBody(
                                              complexCode: complex.code,
                                              userId: auth.userId.toString(),
                                            ),
                                          );

                                          // ignore: use_build_context_synchronously
                                          Navigator.of(context).pop();

                                          if (response["success"]) {
                                            auth.checkLoggin();
                                            showSuccessMessage(
                                              response["message"] ??
                                                  "Complex removed!",
                                            );
                                            setState(() {
                                              isLoading = true;
                                            });
                                            listComplex();
                                            return;
                                          }
                                          showErrorMessage(
                                            response["message"] ??
                                                "Error in removing complex!",
                                          );
                                        },
                                      ),
                                      TextButton(
                                        child: const Text(
                                          'No',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        onPressed: () {
                                          // Do something when the "No" button is pressed.
                                          Navigator.of(dialogueContext).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                        childCount: listComplexs
                            .length, // The number of items in the list
                      ),
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

  @override
  void dispose() {
    complexId.dispose();
    super.dispose();
  }

  Future<void> listComplex() async {
    final response = await ComplexService.listComplex();
    setState(() {
      listComplexs = response;
      isLoading = false;
    });
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
