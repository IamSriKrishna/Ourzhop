
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryItemWidget extends StatelessWidget {
  final String emoji;
  final String name;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryItemWidget({
    super.key,
    required this.emoji,
    required this.name,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isSelected
                  ? context.appColors.primary
                  : context.appColors.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: isSelected
                  ? context.appColors.primary
                  : context.appColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}