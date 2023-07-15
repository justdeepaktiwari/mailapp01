import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mailapp01/providers/auth_provider.dart';
import 'package:mailapp01/screens/auth/signin_screen.dart';
import 'package:mailapp01/screens/complex/complex_screen.dart';
import 'package:mailapp01/screens/complex/request_complex.dart';
import 'package:mailapp01/screens/notifications_screen.dart';
import 'package:mailapp01/screens/profile_screen.dart';
import 'package:mailapp01/screens/setting_screen.dart';
import 'package:mailapp01/services/complex/complex_services.dart';
import 'package:mailapp01/services/complex/join_body.dart';
import 'package:mailapp01/utils/constants.dart';
import 'package:mailapp01/widgets/bottom_navigation.dart';
import 'package:mailapp01/widgets/button.dart';
import 'package:mailapp01/widgets/processing_dialog.dart';
import 'package:mailapp01/widgets/text_diffrent_color.dart';
import 'package:mailapp01/widgets/text_field.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  //Complex Id
  TextEditingController complexId = TextEditingController();

  // Maintain Screen History
  List<int> screenHistory = [];

  // Bottom navigation bar indexs
  int _selectedIndex = 0;

  // List of widget showing on changing according to bottom button
  final List<Widget> _widgetOptions = [
    const NotificationsScreen(),
    const ComplexsScreen(),
    const ProfileScreen(),
    const SettingScreen()
  ];

  @override
  void initState() {
    getConnectivity();
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    navigate(authProvider.isLoggedIn);
  }

  void navigate(isLoggedIn) {
    if (!isLoggedIn) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press
        if (screenHistory.isNotEmpty) {
          int previousPage = screenHistory.length - 1;
          setState(() {
            _selectedIndex = screenHistory[previousPage];
            screenHistory.removeLast();
          });
          // Prevent default back button behavior
          return false;
        }
        // Allow default back button behavior
        return true;
      },
      child: Scaffold(
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: BottomNavigationBarUtils(
          isLoggedIn: auth.isLoggedIn,
          onItemTapped: onItemTapped,
          selectIndex: _selectedIndex,
        ),
        backgroundColor: AppConstants.primaryColor,
        floatingActionButton: _selectedIndex == 1
            ? FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    useSafeArea: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: AppConstants.primaryColor,
                        content: SizedBox(
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFieldWidget(
                                labelText: "Complex Id",
                                editingController: complexId,
                                isPasswordType: false,
                                textInputType: TextInputType.text,
                              ),
                              const SizedBox(
                                height: 15,
                                width: double.infinity,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RequestComplex(),
                                    ),
                                  );
                                },
                                child: const TextDiffrentColorWidget(
                                  startText: "Don’t See your Complex ID?",
                                  endText: " Click Here",
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                                width: double.infinity,
                              ),
                              ButtonWidget(
                                onPressed: () async {
                                  if (complexId.text == '') {
                                    return;
                                  }

                                  _showProcessingDialog();
                                  final response =
                                      await ComplexService.joinComplex(
                                    JoinComplexBody(
                                      complexCode: complexId.text,
                                      userId: auth.userId.toString(),
                                    ),
                                  );

                                  complexId.text = '';

                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();

                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();

                                  if (response["success"]) {
                                    auth.checkLoggin();
                                    complexId.text = '';
                                    auth.refreshTrue();
                                    setState(() {});
                                    showSuccessMessage(
                                      response["message"] ??
                                          "You joined complex!",
                                    );
                                    return;
                                  }
                                  showErrorMessage(
                                    response["message"] ??
                                        "Error in joining complex!",
                                  );
                                },
                                buttonName: "Join",
                              ),
                              const SizedBox(
                                height: 20,
                                width: double.infinity,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    child: const Text(
                                      "Close",
                                      style: TextStyle(
                                        color: AppConstants.white,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Icon(Icons.add),
              )
            : null,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      if (screenHistory.length > 4) {
        if (_selectedIndex != 0) {
          screenHistory = [0];
        } else {
          screenHistory.clear();
        }
      }
      screenHistory.add(_selectedIndex);
      _selectedIndex = index;
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

  getConnectivity() async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (!isDeviceConnected && isAlertSet == false) {
      showDialogBox();
      setState(() => isAlertSet = true);
    }

    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() => isAlertSet = true);
        }
      },
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    complexId.dispose();
    super.dispose();
  }

  showDialogBox() {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('No Connection'),
        content: const Text('Please check your internet connectivity'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.pop(context, 'Cancel');
              setState(() => isAlertSet = false);
              isDeviceConnected =
                  await InternetConnectionChecker().hasConnection;
              if (!isDeviceConnected && isAlertSet == false) {
                showDialogBox();
                setState(() => isAlertSet = true);
              } else {
                // ignore: use_build_context_synchronously
                Provider.of<AuthProvider>(context, listen: false).refreshTrue();
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
