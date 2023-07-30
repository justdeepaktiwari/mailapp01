import 'package:flutter/material.dart';
import 'package:mailapp01/utils/constants.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatefulWidget {
  final String? errorText;

  final String labelText;
  final bool isPasswordType;

  final int? minLines;
  final int? maxLines;

  TextEditingController editingController;
  TextInputType textInputType;

  TextFieldWidget({
    super.key,
    required this.labelText,
    required this.editingController,
    required this.isPasswordType,
    required this.textInputType,
    this.errorText,
    this.minLines,
    this.maxLines,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _isVisible = false;

  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.editingController,
      obscureText: widget.isPasswordType ? !_isVisible : false,
      enableSuggestions: true,
      autocorrect: true,
      keyboardType: widget.textInputType,
      style: const TextStyle(color: AppConstants.white),
      decoration: InputDecoration(
        labelStyle: const TextStyle(
          color: AppConstants.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        errorText: widget.errorText,
        labelText: widget.labelText,
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
        prefixText: widget.textInputType == TextInputType.phone ? "+1 " : null,
        prefixStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        suffixIcon: widget.isPasswordType
            ? IconButton(
                onPressed: () => updateStatus(),
                icon:
                    Icon(_isVisible ? Icons.visibility : Icons.visibility_off),
              )
            : null,
      ),
    );
  }
}
