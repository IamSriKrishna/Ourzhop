
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/features/store/presentation/widgets/quantity_button.dart';
import 'package:flutter/material.dart';

class QuantityAdjuster extends StatelessWidget {
  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  const QuantityAdjuster({
    super.key,
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        QuantityButton(
          icon: Icons.remove,
          onTap: onDecrease,
        ),
        Text(
          '$quantity',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: context.appColors.onSurface,
          ),
        ),
        QuantityButton(
          icon: Icons.add,
          onTap: onIncrease,
        ),
      ],
    );
  }
}