import 'package:flutter/material.dart';
import 'package:mailapp01/screens/complex/request_complex.dart';
import 'package:mailapp01/utils/constants.dart';
import 'package:mailapp01/widgets/button.dart';
import 'package:mailapp01/widgets/text_diffrent_color.dart';
import 'package:mailapp01/widgets/text_field.dart';

// ignore: must_be_immutable
class RequestComplexCardWidget extends StatelessWidget {
  TextEditingController complexId;

  VoidCallback onTap;

  RequestComplexCardWidget({
    super.key,
    required this.complexId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            color: AppConstants.cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                          builder: (context) => const RequestComplex(),
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
                    onPressed: onTap,
                    buttonName: "Join",
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
