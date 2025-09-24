
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ProductInfoSection extends StatelessWidget {
  final String name;
  final String weight;
  final String price;
  final String originalPrice;

  const ProductInfoSection({
    super.key,
    required this.name,
    required this.weight,
    required this.price,
    required this.originalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 1.3,
            color: context.appColors.onSurface,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          weight,
          style: TextStyle(
            fontSize: 10,
            color: context.appColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              price,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: context.appColors.onSurface,
              ),
            ),
            if (originalPrice != price) ...[
              const SizedBox(width: 4),
              Text(
                originalPrice,
                style: TextStyle(
                  fontSize: 10,
                  color: context.appColors.onSurfaceVariant,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}