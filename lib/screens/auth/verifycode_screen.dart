import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mailapp01/providers/auth_provider.dart';
import 'package:mailapp01/screens/home_screen.dart';
import 'package:mailapp01/services/auth/auth_service.dart';
import 'package:mailapp01/services/auth/verify_body.dart';
import 'package:mailapp01/utils/constants.dart';
import 'package:mailapp01/widgets/button.dart';
import 'package:mailapp01/widgets/processing_dialog.dart';
import 'package:mailapp01/widgets/text_diffrent_color.dart';
import 'package:provider/provider.dart';

class VerifyUserScreen extends StatefulWidget {
  const VerifyUserScreen({super.key});

  @override
  State<VerifyUserScreen> createState() => _VerifyUserScreenState();
}

class _VerifyUserScreenState extends State<VerifyUserScreen> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  bool _hasError = false;

  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;

  late Timer _timer;
  int _currentDuration = 1 * 10;

  @override
  void initState() {
    getConnectivity();
    super.initState();
    _focusNodes = List.generate(6, (_) => FocusNode());
    _controllers = List.generate(6, (_) => TextEditingController());
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
              width: double.infinity,
            ),
            const Center(
              child: Text(
                "Verify Account",
                style: TextStyle(
                  fontSize: 40,
                  color: AppConstants.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 80,
              width: double.infinity,
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppConstants.appColor,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
              width: double.infinity,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Enter Code",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: _currentDuration > 0
                          ? TextDiffrentColorWidget(
                              startText:
                                  "Your verification code will exprie in",
                              endText: "  ${_formatDuration(_currentDuration)}",
                              startFontSize: 16,
                              endFontSize: 16,
                            )
                          : GestureDetector(
                              child: const TextDiffrentColorWidget(
                                startText: "Code expried send again",
                                endText: " Click Here",
                                startFontSize: 16,
                                endFontSize: 16,
                              ),
                              onTap: () {
                                setState(() {
                                  _currentDuration = 15 * 60;
                                  _startTimer();
                                  setState(() {
                                    _hasError = false;
                                  });
                                });
                              },
                            ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:
                          List.generate(6, (index) => _buildDigitField(index)),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: _hasError
                          ? const Text(
                              "Please Enter 6-digit code properly",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(
                      height: 10,
                      width: double.infinity,
                    ),
                    const SizedBox(
                      height: 20,
                      width: double.infinity,
                    ),
                    ButtonWidget(
                      buttonName: "Verify Now",
                      onPressed: () async {
                        setState(() {
                          _hasError = false;
                        });
                        for (var element in _controllers) {
                          if (element.text == '') {
                            setState(() {
                              _hasError = true;
                            });
                            return;
                          }
                        }

                        _showProcessingDialog();

                        String code = '';
                        for (var i = 0; i < 6; i++) {
                          code += _controllers[i].text;
                        }

                        if (auth.userInfo["phone"] != "") {
                          final response = await AuthService.verifyUser(
                            VerifyBody(code, auth.userInfo["phone"]),
                          );

                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();

                          if (response["success"]) {
                            auth.checkLoggin();

                            showSuccessMessage(
                              response["message"] ?? "Successfully Verified",
                            );

                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          } else {
                            showErrorMessage(
                              response["message"] ?? "Error in sending code",
                            );
                          }
                        } else {
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 50,
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppConstants.primaryColor,
    );
  }

  Widget _buildDigitField(int index) {
    return Container(
      width: 40,
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, color: AppConstants.white),
        decoration: InputDecoration(
          counterText: '',
          contentPadding: const EdgeInsets.all(1),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.zero),
            borderSide: BorderSide(
              color: _hasError ? Colors.red : AppConstants.appColor,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.zero),
            borderSide: BorderSide(
              color: _hasError ? Colors.red : AppConstants.appColor,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.zero),
            borderSide: BorderSide(
              color: _hasError ? Colors.red : AppConstants.appColor,
              width: 2.0,
            ),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < 5) {
              _focusNodes[index].unfocus();
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            } else {
              _focusNodes[index].unfocus();
            }
          } else {
            if (index > 0) {
              _focusNodes[index].unfocus();
              FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
            }
          }
        },
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
    for (var i = 0; i < 6; i++) {
      _controllers[i].dispose();
    }
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_currentDuration > 0) {
          _currentDuration--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  String _formatDuration(int duration) {
    int minutes = duration ~/ 60;
    int seconds = duration % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  showDialogBox() => showCupertinoDialog<String>(
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
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
