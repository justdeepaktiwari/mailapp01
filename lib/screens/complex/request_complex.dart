import 'package:flutter/material.dart';
import 'package:mailapp01/utils/constants.dart';
import 'package:mailapp01/widgets/page_heading.dart';

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
    );
  }
}
