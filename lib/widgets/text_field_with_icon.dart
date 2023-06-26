import 'package:flutter/material.dart';
import 'package:mailapp01/utils/constants.dart';

// ignore: must_be_immutable
class TextFieldIconWidget extends StatelessWidget {
  final String labelText;
  final bool isPasswordType;
  TextEditingController editingController;
  TextInputType textInputType;

  TextFieldIconWidget({
    super.key,
    required this.labelText,
    required this.editingController,
    required this.isPasswordType,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: editingController,
      obscureText: isPasswordType,
      enableSuggestions: true,
      autocorrect: true,
      keyboardType: textInputType,
      style: const TextStyle(color: AppConstants.appColor),
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.edit, color: AppConstants.appColor),
        labelStyle: const TextStyle(
          color: AppConstants.appColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppConstants.appColor,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppConstants.appColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppConstants.appColor,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.all(20),
      ),
    );
  }
}
