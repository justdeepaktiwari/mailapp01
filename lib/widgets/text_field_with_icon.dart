import 'package:flutter/material.dart';
import 'package:mailapp01/utils/constants.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
      inputFormatters: textInputType == TextInputType.phone ? [maskFormatter] : [],
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
        prefixText: textInputType == TextInputType.phone ? "+1 " : null,
        prefixStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
   var maskFormatter = MaskTextInputFormatter(
      mask: '(###) ###-##-##', 
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
    );
}
