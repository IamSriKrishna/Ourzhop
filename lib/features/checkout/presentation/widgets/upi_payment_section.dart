// ignore_for_file: deprecated_member_use

import 'package:customer_app/constants/app_icons.dart';
import 'package:customer_app/features/checkout/presentation/widgets/card_details_section.dart';
import 'package:customer_app/features/checkout/presentation/widgets/card_input_field.dart';
import 'package:customer_app/features/checkout/presentation/widgets/payment_method_card.dart';
import 'package:flutter/material.dart';

class UpiPaymentSection extends StatelessWidget {
  final ColorScheme colorScheme;

  const UpiPaymentSection({
    super.key,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'UPI',
          colorScheme: colorScheme,
        ),
        const SizedBox(height: 12),
        _UpiOptionsCard(colorScheme: colorScheme),
        const SizedBox(height: 16),
        _UpiIdInput(colorScheme: colorScheme),
      ],
    );
  }
}

class _UpiOptionsCard extends StatelessWidget {
  final ColorScheme colorScheme;

  const _UpiOptionsCard({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return Container(
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
          UpiOptionTile(
            title: 'Google Pay',
            subtitle: '50% Cash back',
            icon: AppIcons.gpay,
            iconColor: Colors.purple,
            colorScheme: colorScheme,
          ),
          _Divider(colorScheme: colorScheme),
          UpiOptionTile(
            title: 'Phone Pay',
            subtitle: '10% Cash back',
            icon: AppIcons.paytm,
            iconColor: Colors.blue,
            colorScheme: colorScheme,
          ),
          _Divider(colorScheme: colorScheme),
          UpiOptionTile(
            title: 'CRED',
            subtitle: '',
            icon: AppIcons.cred,
            iconColor: Colors.black,
            colorScheme: colorScheme,
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  final ColorScheme colorScheme;

  const _Divider({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        height: 1,
        thickness: 1,
        color: colorScheme.outline.withOpacity(0.1),
      ),
    );
  }
}

class UpiOptionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final Color iconColor;
  final ColorScheme colorScheme;
  final bool isLast;

  const UpiOptionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.colorScheme,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          RadioButton(colorScheme: colorScheme),
          const SizedBox(width: 16),
          Expanded(
            child: _UpiOptionInfo(
              title: title,
              subtitle: subtitle,
              colorScheme: colorScheme,
            ),
          ),
          const SizedBox(width: 12),
          _UpiIcon(
            icon: icon,
            iconColor: iconColor,
          ),
        ],
      ),
    );
  }
}

class _UpiOptionInfo extends StatelessWidget {
  final String title;
  final String subtitle;
  final ColorScheme colorScheme;

  const _UpiOptionInfo({
    required this.title,
    required this.subtitle,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
        if (subtitle.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: colorScheme.onSurface.withOpacity(0.6),
              fontSize: 13,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ],
    );
  }
}

class _UpiIcon extends StatelessWidget {
  final String icon;
  final Color iconColor;

  const _UpiIcon({
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(
        icon,
        height: 24,
        width: 24,
      ),
    );
  }
}

class _UpiIdInput extends StatelessWidget {
  final ColorScheme colorScheme;

  const _UpiIdInput({required this.colorScheme});

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
      child: CardInputField(
        label: 'UPI ID',
        hint: 'Full Name',
        colorScheme: colorScheme,
      ),
    );
  }
}
