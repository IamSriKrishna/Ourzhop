import 'package:flutter/material.dart';

class ProductPriceWidget extends StatelessWidget {
  final String price;
  final String originalPrice;

  const ProductPriceWidget({
    super.key,
    required this.price,
    required this.originalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Text(
              '₹$price',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '₹$originalPrice',
              style: TextStyle(
                fontSize: 14,
                decoration: TextDecoration.lineThrough,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
