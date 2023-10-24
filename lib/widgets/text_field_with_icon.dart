import 'package:flutter/material.dart';
import 'package:mailapp01/utils/constants.dart';

// ignore: must_be_immutable
class TextFieldIconWidget extends StatelessWidget {
  final String labelText;
  final bool isPasswordType;

  final String? errorText;

  TextEditingController editingController;
  TextInputType textInputType;

  final bool isNotUpdatedField;
  TextFieldIconWidget({
    super.key,
    required this.labelText,
    required this.editingController,
    required this.isPasswordType,
    required this.textInputType,
    this.isNotUpdatedField = false,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: editingController,
      obscureText: isPasswordType,
      enableSuggestions: true,
      autocorrect: true,
      enabled: isNotUpdatedField,
      keyboardType: textInputType,
      style: const TextStyle(
        color: AppConstants.white,
      ),
      decoration: InputDecoration(
        suffixIcon: isNotUpdatedField
            ? const Icon(Icons.edit, color: AppConstants.appColor)
            : null,
        labelStyle: const TextStyle(
          color: AppConstants.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        labelText: labelText,
        errorText: errorText,
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
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.all(20),
      ),
    );
  }
}

class TextFieldIconWidgetNumber extends StatelessWidget {
  late final String labelText;
  late final bool isPasswordType;

  late final String? errorText;

  late TextEditingController editingController;
  late TextInputType textInputType;

  final bool isNotUpdatedField;
  TextFieldIconWidgetNumber({
    super.key,
    required this.labelText,
    required this.editingController,
    required this.isPasswordType,
    required this.textInputType,
    this.isNotUpdatedField = false,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: editingController,
      obscureText: isPasswordType,
      enableSuggestions: true,
      autocorrect: true,
      enabled: isNotUpdatedField,
      keyboardType: textInputType,
      style: const TextStyle(
        color: AppConstants.white,
      ),
      decoration: InputDecoration(
        suffixIcon: isNotUpdatedField
            ? const Icon(Icons.edit, color: AppConstants.appColor)
            : null,
        labelStyle: const TextStyle(
          color: AppConstants.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        labelText: labelText,
        errorText: errorText,
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
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.all(20),
      ),
    );
  }
}
