import 'package:flutter/material.dart';

class ProductDetailsSection extends StatelessWidget {
  final String description;
  final VoidCallback? onViewMore;

  const ProductDetailsSection({
    super.key,
    required this.description,
    this.onViewMore,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: onViewMore,
          child: const Text(
            'View more...',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF8B5CF6),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
