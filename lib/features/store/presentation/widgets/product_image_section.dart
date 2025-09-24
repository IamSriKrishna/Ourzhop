
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/features/store/presentation/widgets/discount_badge.dart';
import 'package:flutter/material.dart';

class ProductImageSection extends StatelessWidget {
  final String image;
  final bool hasDiscount;
  final String? discountPercentage;

  const ProductImageSection({
    super.key,
    required this.image,
    required this.hasDiscount,
    this.discountPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: context.appColors.surfaceVariant,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              image,
              style: const TextStyle(fontSize: 40),
            ),
          ),
        ),
        if (hasDiscount && discountPercentage != null)
          Positioned(
            top: 4,
            right: 4,
            child: DiscountBadge(discount: discountPercentage!),
          ),
      ],
    );
  }
}