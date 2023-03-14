// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({required this.labelText, this.onChanged, this.validate});
  String labelText;
  Function(String)? onChanged;
  String? Function(String?)? validate;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validate,
      onChanged: onChanged,
      decoration: InputDecoration(
        label: Text(
          labelText,
          style: const TextStyle(color: Colors.white),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
