// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class PaymentMethodCard extends StatelessWidget {
  final ColorScheme colorScheme;

  const PaymentMethodCard({
    super.key,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: isDark ? null : Colors.white,
        borderRadius: BorderRadius.circular(12),
          gradient: isDark
            ? LinearGradient(
                colors: [
                  colorScheme.primary.withOpacity(0.1),
                  colorScheme.primary.withOpacity(0.05),
                ],
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          RadioButton(colorScheme: colorScheme),
          const SizedBox(width: 16),
          Expanded(
            child: _PaymentMethodInfo(colorScheme: colorScheme),
          ),
        ],
      ),
    );
  }
}

class RadioButton extends StatelessWidget {
  final ColorScheme colorScheme;

  const RadioButton({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.5),
          width: 2,
        ),
      ),
    );
  }
}

class _PaymentMethodInfo extends StatelessWidget {
  final ColorScheme colorScheme;

  const _PaymentMethodInfo({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cash on Delivery',
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Additional charge may apply',
          style: TextStyle(
            color: colorScheme.onSurface.withOpacity(0.6),
            fontSize: 13,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.1,
          ),
        ),
      ],
    );
  }
}
