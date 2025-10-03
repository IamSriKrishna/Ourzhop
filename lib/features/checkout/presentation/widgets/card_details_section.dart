// ignore_for_file: deprecated_member_use

import 'package:customer_app/features/checkout/presentation/widgets/card_input_field.dart';
import 'package:flutter/material.dart';

class CardDetailsSection extends StatelessWidget {
  final ColorScheme colorScheme;

  const CardDetailsSection({
    super.key,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Card',
          colorScheme: colorScheme,
        ),
        const SizedBox(height: 12),
        _CardForm(colorScheme: colorScheme),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final ColorScheme colorScheme;

  const SectionTitle({
    super.key,
    required this.title,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

class _CardForm extends StatelessWidget {
  final ColorScheme colorScheme;

  const _CardForm({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardInputField(
            label: 'Card Number',
            hint: '0000 / 0000 / 0000 / 0000',
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 20),
          CardInputField(
            label: 'Name on Card',
            hint: 'Full Name',
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CardInputField(
                  label: 'Month / Year',
                  hint: '00 / 00',
                  colorScheme: colorScheme,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CardInputField(
                  label: 'CVV',
                  hint: '123',
                  colorScheme: colorScheme,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
