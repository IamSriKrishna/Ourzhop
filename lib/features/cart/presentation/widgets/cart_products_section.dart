// widgets/cart_products_section.dart
// ignore_for_file: deprecated_member_use

import 'package:customer_app/features/home/presentation/cubit/cart/cart_cubit.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProductsSection extends StatelessWidget {
  final CartState cartState;
  final EdgeInsets? margin;

  const CartProductsSection({
    super.key,
    required this.cartState,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Products (${cartState.totalItems})',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ...cartState.items.map((item) => CartItemWidget(item: item)),
        ],
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;

  const CartItemWidget({
    super.key,
    required this.item,
    this.margin,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
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
      child: Row(
        children: [
          _ProductImage(item: item),
          const SizedBox(width: 12),
          Expanded(
            child: _ProductDetails(item: item),
          ),
          _QuantityControls(
            item: item,
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final CartItem item;
  final double size;

  const _ProductImage({
    required this.item,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.image,
        color: Colors.grey,
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final CartItem item;

  const _ProductDetails({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        if (item.weight.isNotEmpty)
          Text(
            item.weight,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              item.price,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (item.discount != null && item.originalPrice.isNotEmpty) ...[
              const SizedBox(width: 8),
              Text(
                item.originalPrice,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _QuantityControls extends StatelessWidget {
  final CartItem item;
  final ColorScheme colorScheme;

  const _QuantityControls({
    required this.item,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _QuantityButton(
          icon: Icons.remove,
          onPressed: () => context.read<CartCubit>().removeItem(item.id),
          backgroundColor: colorScheme.primary,
          iconColor: colorScheme.onPrimary,
        ),
        const SizedBox(width: 12),
        Container(
          constraints: const BoxConstraints(minWidth: 24),
          child: Text(
            '${item.quantity}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 12),
        _QuantityButton(
          icon: Icons.add,
          onPressed: () => context.read<CartCubit>().addItem(item),
          backgroundColor: colorScheme.primary,
          iconColor: colorScheme.onPrimary,
        ),
        const SizedBox(width: 8),
        _QuantityButton(
          icon: Icons.close,
          onPressed: () => context.read<CartCubit>().removeItem(item.id),
          backgroundColor: Colors.grey.shade200,
          iconColor: Colors.grey,
        ),
      ],
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color iconColor;
  final double size;

  const _QuantityButton({
    required this.icon,
    required this.onPressed,
    required this.backgroundColor,
    required this.iconColor,
    this.size = 28,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 16,
        ),
      ),
    );
  }
}
