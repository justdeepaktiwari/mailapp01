import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mailapp01/providers/auth_provider.dart';
import 'package:mailapp01/services/complex/request_body.dart';
import 'package:mailapp01/services/complex/complex_services.dart';
import 'package:mailapp01/utils/constants.dart';
import 'package:mailapp01/widgets/page_heading.dart';
import 'package:mailapp01/widgets/processing_dialog.dart';
import 'package:provider/provider.dart';

import '../../widgets/button.dart';
import '../../widgets/text_field.dart';

class RequestComplex extends StatefulWidget {
  const RequestComplex({Key? key}) : super(key: key);

  @override
  State<RequestComplex> createState() => _RequestComplexState();
}

class _RequestComplexState extends State<RequestComplex> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  bool complexNameError = false;
  bool complexLocationError = false;

  TextEditingController complexName = TextEditingController();
  TextEditingController complexLocation = TextEditingController();
  TextEditingController notes = TextEditingController();

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryColor,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: AppConstants.appColor,
        elevation: 2.0,
        actions: const [
          Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: PageHeadingWidget(
                headingText: "Request Complex",
              ),
            ),
          ),
        ],
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ListView(
          children: [
            const SizedBox(
              height: 80,
            ),
            const Text(
              "If your complex is currently not using mailbx, we will reach out to them on behalf of you.",
              style: TextStyle(
                color: AppConstants.white,
                fontSize: 17,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              labelText: "Complex Name",
              editingController: complexName,
              isPasswordType: false,
              textInputType: TextInputType.text,
              errorText: complexNameError ? "Complex name required" : null,
            ),
            const SizedBox(
              height: 20,
              width: double.infinity,
            ),
            TextFieldWidget(
              labelText: "Complex Location",
              editingController: complexLocation,
              isPasswordType: false,
              textInputType: TextInputType.multiline,
              errorText:
                  complexLocationError ? "Complex location required" : null,
            ),
            const SizedBox(
              height: 20,
              width: double.infinity,
            ),
            TextFieldWidget(
              labelText: "Notes",
              editingController: notes,
              isPasswordType: false,
              textInputType: TextInputType.multiline,
              minLines: 2,
              maxLines: 5,
            ),
            const SizedBox(
              height: 20,
              width: double.infinity,
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
              buttonName: "Request complex",
              onPressed: () async {
                FocusScope.of(context).unfocus();

                complexNameError = complexName.text == '' ? true : false;
                complexLocationError =
                    complexLocation.text == '' ? true : false;

                if (complexLocationError || complexNameError) {
                  setState(() {});
                  return;
                }

                _showProcessingDialog();

                final response = await ComplexService.requestComplex(
                  RequestComplexBody(
                    name: complexName.text,
                    complexLocation: complexLocation.text,
                    notes: notes.text,
                  ),
                );

                complexName.text = '';
                complexLocation.text = '';
                notes.text = '';

                if (response["success"]) {
                  showSuccessMessage(
                    response["message"] ?? "Successfully requested!",
                  );
                } else {
                  showErrorMessage(
                    response["message"] ?? "Error in requesting complex",
                  );
                }
                setState(() {});
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(
              height: 50,
              width: double.infinity,
            ),
          ],
        ),
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

  @override
  void dispose() {
    subscription.cancel();
    complexName.dispose();
    complexLocation.dispose();
    notes.dispose();
    super.dispose();
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
