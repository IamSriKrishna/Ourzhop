// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class ItemDetailsSection extends StatelessWidget {
  final ColorScheme colorScheme;

  const ItemDetailsSection({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            'Item Details (7)',
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? null : Colors.white,
        gradient: isDark
            ? LinearGradient(
                colors: [
                  colorScheme.primary.withOpacity(0.1),
                  colorScheme.primary.withOpacity(0.05),
                ],
              )
            : null,
        borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _ItemRow(
                name: 'Item',
                quantity: 'x 1',
                price: '₹180',
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 12),
              _ItemRow(
                name: 'Item',
                quantity: 'x 2',
                price: '₹180',
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 12),
              _ItemRow(
                name: 'Item',
                quantity: 'x 2',
                price: '₹180',
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 12),
              _ItemRow(
                name: 'Item',
                quantity: 'x 2',
                price: '₹180',
                colorScheme: colorScheme,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ItemRow extends StatelessWidget {
  final String name;
  final String quantity;
  final String price;
  final ColorScheme colorScheme;

  const _ItemRow({
    required this.name,
    required this.quantity,
    required this.price,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            name,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          quantity,
          style: TextStyle(
            color: colorScheme.onSurface.withOpacity(0.6),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 24),
        Text(
          price,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
