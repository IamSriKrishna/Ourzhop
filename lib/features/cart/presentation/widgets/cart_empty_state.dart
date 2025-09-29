import 'package:customer_app/constants/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CartEmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final Widget? icon;

  const CartEmptyState({
    super.key,
    this.title = 'Cart is empty',
    this.subtitle = 'Add products to the cart to continue...',
    this.buttonText = 'Continue Shopping',
    this.onButtonPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SliverToBoxAdapter(
      child: Container(
        color: colorScheme.surface,
        child: Column(
          children: [
            const SizedBox(height: 80),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                children: [
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(height: 24),
                  ],
                  const SizedBox(height: 40),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 16,
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),
                  _ActionButton(
                    text: buttonText,
                    onPressed: onButtonPressed ?? _defaultButtonAction(context),
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  VoidCallback _defaultButtonAction(BuildContext context) {
    return () => context.goNamed(AppRoutes.home);
  }
}

class _ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ColorScheme colorScheme;

  const _ActionButton({
    required this.text,
    required this.onPressed,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
