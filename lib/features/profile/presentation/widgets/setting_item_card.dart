// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class SettingItemCard extends StatelessWidget {
  final String icon;
  final String title;
  final String? subtitle;
  final bool isLast;
  final void Function()? onTap;

  const SettingItemCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: colorScheme.primary.withOpacity(0.1),
        highlightColor: colorScheme.primary.withOpacity(0.05),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      icon,
                      fit: BoxFit.contain,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: colorScheme.onSurface,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.1,
                            height: 1.3,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            subtitle!,
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.1,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: colorScheme.onSurfaceVariant.withOpacity(0.5),
                    size: 24,
                  ),
                ],
              ),
              if (!isLast)
                Padding(
                  padding: const EdgeInsets.only(left: 60, top: 16),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: colorScheme.outlineVariant,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
