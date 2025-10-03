// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class BillDetailsSection extends StatelessWidget {
  final ColorScheme colorScheme;

  const BillDetailsSection({super.key, required this.colorScheme});

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
            'Bill Details',
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
              _BillRow(
                label: 'MRP Total',
                value: '₹ 390.00',
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 12),
              _BillRow(
                label: 'Product Discount',
                value: '- ₹ 10.00',
                valueColor: Colors.green,
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 12),
              _BillRow(
                label: 'Delivery Fee',
                value: 'FREE',
                valueColor: Colors.green,
                colorScheme: colorScheme,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: colorScheme.outline.withOpacity(0.1),
                ),
              ),
              _BillRow(
                label: 'Total',
                value: '₹ 380.00',
                isBold: true,
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 16),
              _BillRow(
                label: 'Payment Mode',
                value: 'UPI: user@upi',
                colorScheme: colorScheme,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BillRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isBold;
  final ColorScheme colorScheme;

  const _BillRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isBold = false,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: colorScheme.onSurface.withOpacity(0.7),
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? colorScheme.onSurface,
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
