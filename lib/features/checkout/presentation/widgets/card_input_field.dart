// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CardInputField extends StatelessWidget {
  final String label;
  final String hint;
  final ColorScheme colorScheme;

  const CardInputField({
    super.key,
    required this.label,
    required this.hint,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: colorScheme.onSurface.withOpacity(0.6),
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: colorScheme.onSurface.withOpacity(0.4),
          fontSize: 15,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.2,
        ),
        filled: true,
        fillColor: colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 1.5,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
