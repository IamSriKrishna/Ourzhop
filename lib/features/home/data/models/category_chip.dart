
import 'package:flutter/material.dart';

class CategoryChip {
  final String title;
  final bool isSelected;
  final VoidCallback? onTap;

  CategoryChip({
    required this.title,
    this.isSelected = false,
    this.onTap,
  });
}
