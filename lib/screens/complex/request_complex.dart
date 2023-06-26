import 'package:flutter/material.dart';
import 'package:mailapp01/utils/constants.dart';

import '../../widgets/button.dart';
import '../../widgets/text_field.dart';

class RequestComplex extends StatefulWidget {
  const RequestComplex({Key? key}) : super(key: key);

  @override
  State<RequestComplex> createState() => _RequestComplexState();
}

class _RequestComplexState extends State<RequestComplex> {
  TextEditingController complexName = TextEditingController();
  TextEditingController complexLocation = TextEditingController();
  TextEditingController notes = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryColor,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: AppConstants.appColor,
        elevation: 2.0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Request Complex",
                style: TextStyle(
                    color: AppConstants.appColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "If your complex is currently not using mailbx, \nwe will reach out to them on behalf of you.",
                style: TextStyle(
                  color: AppConstants.appColor,
                  fontSize: 12,
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
              ),
              const SizedBox(
                height: 20,
                width: double.infinity,
              ),
              TextFieldWidget(
                labelText: "Complex Location",
                editingController: complexLocation,
                isPasswordType: false,
                textInputType: TextInputType.phone,
              ),
              const SizedBox(
                height: 20,
                width: double.infinity,
              ),
              TextFieldWidget(
                labelText: "Notes",
                editingController: notes,
                isPasswordType: false,
                textInputType: TextInputType.emailAddress,
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
                onPressed: () {},
              ),
              const SizedBox(
                height: 50,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
