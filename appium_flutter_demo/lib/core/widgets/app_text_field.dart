import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.inputKey,
    this.semanticsLabel,
    required this.label,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.inputFormatters,
    this.onFieldSubmitted,
  });

  final Key? inputKey;
  final String? semanticsLabel;
  final String label;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    final field = TextFormField(
      key: inputKey,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      inputFormatters: inputFormatters,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(labelText: label),
    );

    if (semanticsLabel == null) return field;

    // Distinct semantics node so UiAutomator2 exposes content-desc on Android.
    return Semantics(
      label: semanticsLabel,
      container: true,
      explicitChildNodes: true,
      child: field,
    );
  }
}
