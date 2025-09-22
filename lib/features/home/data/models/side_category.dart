
import 'package:flutter/material.dart';

class SideCategory {
  final BuildContext context;
  final String emoji;
  final String name;
  final bool isSelected;
  final VoidCallback? onTap;

  SideCategory({
    required this.context,
    required this.emoji,
    required this.name,
    this.isSelected = false,
    this.onTap,
  });
}