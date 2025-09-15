import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/app_theme.dart';

enum TextFieldType {
  text,
  number,
  decimal,
  multiline,
}

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextFieldType type;
  final Function(String) onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.onChanged,
    this.type = TextFieldType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: _getKeyboardType(),
      inputFormatters: _getInputFormatters(),
      maxLines: maxLines ?? (type == TextFieldType.multiline ? null : 1),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppTheme.backgroundColor,
      ),
      onChanged: onChanged,
    );
  }

  TextInputType _getKeyboardType() {
    switch (type) {
      case TextFieldType.number:
        return TextInputType.number;
      case TextFieldType.decimal:
        return const TextInputType.numberWithOptions(decimal: true);
      case TextFieldType.multiline:
        return TextInputType.multiline;
      case TextFieldType.text:
      default:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter>? _getInputFormatters() {
    switch (type) {
      case TextFieldType.number:
        return [FilteringTextInputFormatter.digitsOnly];
      case TextFieldType.decimal:
        return [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))];
      case TextFieldType.text:
      case TextFieldType.multiline:
      default:
        return null;
    }
  }
}