// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class StoreInfoCard extends StatelessWidget {
  final ColorScheme colorScheme;
  final String storeName;
  final String storeLocation;
  final String myAddress;

  const StoreInfoCard({
    super.key,
    required this.colorScheme,
    this.storeName = 'Store Name',
    this.storeLocation = 'Full Address',
    this.myAddress = 'Full Address',
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
          _InfoRow(
            icon: Icons.store_outlined,
            title: storeName,
            subtitle: storeLocation,
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 16),
          _InfoRow(
            icon: Icons.location_on_outlined,
            title: 'Location',
            subtitle: myAddress,
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final ColorScheme colorScheme;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: colorScheme.onSurface.withOpacity(0.6),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
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
      ],
    );
  }
}
