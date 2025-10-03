// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final VoidCallback? onTap;
  final Widget? leadingWidget;
  final Widget? trailingWidget;

  const UserInfoCard({
    super.key,
    required this.name,
    required this.subtitle,
    this.onTap,
    this.leadingWidget,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;
    final isDark = theme.brightness == Brightness.dark;

    return SliverPadding(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.02,
        horizontal: size.width * 0.04,
      ),
      sliver: SliverToBoxAdapter(
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
            border: isDark
                ? Border.all(
                    color: colorScheme.outline.withOpacity(0.2),
                    width: 1,
                  )
                : null,
          ),
          clipBehavior: Clip.antiAlias,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              splashColor: colorScheme.primary.withOpacity(0.08),
              highlightColor: colorScheme.primary.withOpacity(0.04),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    leadingWidget ??
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                colorScheme.primary,
                                colorScheme.primary.withOpacity(0.8),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.primary.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 32,
                            child: Text(
                              name.isNotEmpty ? name[0].toUpperCase() : 'U',
                              style: TextStyle(
                                color: colorScheme.onPrimary,
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2,
                              height: 1.3,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.1,
                              height: 1.3,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (trailingWidget != null)
                      trailingWidget!
                    else if (onTap != null)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.edit_outlined,
                          color: colorScheme.onPrimaryContainer,
                          size: 20,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
