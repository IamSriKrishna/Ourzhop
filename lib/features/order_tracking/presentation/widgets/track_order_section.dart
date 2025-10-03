// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class TrackOrderSection extends StatelessWidget {
  final ColorScheme colorScheme;

  const TrackOrderSection({super.key, required this.colorScheme});

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
            'Track Order',
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
            children: [
              _TrackingStep(
                icon: Icons.check_circle,
                iconColor: Colors.green,
                title: 'Ordered',
                subtitle: 'Wed, 03 Sep - 03:05 PM',
                isCompleted: true,
                showLine: true,
                colorScheme: colorScheme,
              ),
              _TrackingStep(
                icon: Icons.sync,
                iconColor: Colors.orange,
                title: 'Under Process',
                subtitle: 'Wed, 03 Sep - 06:53 PM',
                isCompleted: true,
                showLine: true,
                colorScheme: colorScheme,
              ),
              _TrackingStep(
                icon: Icons.local_shipping,
                iconColor: colorScheme.primary,
                title: 'Shipped',
                subtitle: 'Thu, 04 Sep - 02:00 AM',
                isCompleted: true,
                showLine: true,
                colorScheme: colorScheme,
              ),
              _TrackingStep(
                icon: Icons.schedule,
                iconColor: colorScheme.onSurface.withOpacity(0.3),
                title: 'Expected Delivery',
                subtitle: 'Thu, 04 Sep | Tomorrow',
                isCompleted: false,
                showLine: false,
                colorScheme: colorScheme,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TrackingStep extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool showLine;
  final ColorScheme colorScheme;

  const _TrackingStep({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    required this.showLine,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
              if (showLine)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: colorScheme.outline.withOpacity(0.2),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: showLine ? 16 : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: colorScheme.onSurface.withOpacity(0.5),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
