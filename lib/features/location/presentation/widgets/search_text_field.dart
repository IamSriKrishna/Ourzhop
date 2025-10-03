
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onChanged;
  final VoidCallback onClear;
  final double height;
  final IconData prefixIcon;
  final IconData suffixIcon;

  const SearchTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
    required this.onClear,
    this.height = 56.0,
    this.prefixIcon = Icons.search,
    this.suffixIcon = Icons.clear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[500],
            fontSize: 16,
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.grey[500],
            size: 24,
          ),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(suffixIcon, color: Colors.grey[500]),
                  onPressed: onClear,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 18.0,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}