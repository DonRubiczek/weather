import 'package:flutter/material.dart';
import 'package:weather/theme/app_specific_theme.dart';

class HomeForm extends StatelessWidget {
  HomeForm({
    Key? key,
    this.formKey,
    this.formFieldKey,
    required this.controller,
    this.textInputAction,
    this.textInputType,
    this.validator,
    required this.labelText,
    required this.onFieldSubmitted,
    this.focus,
  }) : super(key: key);

  final Key? formKey;
  final Key? formFieldKey;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextEditingController controller;
  final String labelText;
  final FocusNode? focus;
  final Function(String) onFieldSubmitted;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        key: formFieldKey,
        style: TextStyle(
          color: context.theme.headlineTextColor,
        ),
        keyboardType: textInputType,
        textInputAction: textInputAction,
        validator: validator,
        focusNode: focus,
        controller: controller,
        decoration: InputDecoration(
          labelStyle: TextStyle(
            color: context.theme.headlineTextColor,
          ),
          labelText: labelText,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: context.theme.secondaryColor,
            ),
          ),
        ),
        onFieldSubmitted: onFieldSubmitted,
        onTap: controller.clear,
      ),
    );
  }
}
