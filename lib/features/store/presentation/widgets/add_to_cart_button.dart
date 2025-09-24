import 'package:customer_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AddToCartButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddToCartButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 32,
        decoration: BoxDecoration(
          border: Border.all(color: context.appColors.primary),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: context.appColors.primary,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              'Add',
              style: TextStyle(
                color: context.appColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
