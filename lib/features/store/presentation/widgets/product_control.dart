// Updated product_control.dart
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_cubit.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_state.dart';
import 'package:customer_app/features/home/presentation/models/product_model.dart';
import 'package:customer_app/features/store/presentation/widgets/quantity_adjuster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductControls extends StatelessWidget {
  final Product product;

  const ProductControls({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, cartState) {
        // Check if product has multiple variants
        final hasMultipleVariants = product.variants.length > 1;
        
        if (hasMultipleVariants) {
          // Check if any variant is in cart
          final anyVariantInCart = product.variants.any(
            (v) => cartState.isItemInCart(v.id)
          );
          
          if (!anyVariantInCart) {
            // Show "Choose Variant" button
            return _buildChooseVariantButton(context);
          }
        }
        
        // Show quantity controls for single variant or selected variant
        final selectedVariantId = cartState.getSelectedVariant(product.id) ??
            product.variants.first.id;
        final cartItem = cartState.getItem(selectedVariantId);
        final quantity = cartItem?.quantity ?? 0;

        if (quantity > 0) {
          return QuantityAdjuster(
            quantity: quantity,
            onDecrease: () {
              context.read<CartCubit>().removeItem(selectedVariantId);
            },
            onIncrease: () {
              final variant = product.variants
                  .firstWhere((v) => v.id == selectedVariantId);
              final cartItem = CartItem(
                id: selectedVariantId,
                productId: product.id,
                name: product.name,
                weight: variant.weight,
                price: variant.price,
                originalPrice: variant.originalPrice,
                discount: variant.discount,
              );
              context.read<CartCubit>().addItem(cartItem);
            },
          );
        }

        // Show Add button for single variant
        return _buildAddButton(context, selectedVariantId);
      },
    );
  }

  Widget _buildChooseVariantButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showVariantBottomSheet(context);
      },
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: context.appColors.primary),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.tune, color: context.appColors.primary, size: 14),
            const SizedBox(width: 4),
            Text(
              'Variants',
              style: TextStyle(
                color: context.appColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context, String variantId) {
    return GestureDetector(
      onTap: () {
        final variant = product.variants.firstWhere((v) => v.id == variantId);
        final cartItem = CartItem(
          id: variantId,
          productId: product.id,
          name: product.name,
          weight: variant.weight,
          price: variant.price,
          originalPrice: variant.originalPrice,
          discount: variant.discount,
        );
        context.read<CartCubit>().addItem(cartItem);
      },
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: context.appColors.primary),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: context.appColors.primary, size: 16),
            const SizedBox(width: 4),
            Text(
              'Add',
              style: TextStyle(
                color: context.appColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showVariantBottomSheet(BuildContext context) {
    final cartCubit = context.read<CartCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return BlocProvider<CartCubit>.value(
          value: cartCubit,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                // Drag handle
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 20),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outline,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Select a variant',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.surfaceVariant,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Variants list
                Expanded(
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, cartState) {
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: product.variants.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final variant = product.variants[index];
                          final isInCart = cartState.isItemInCart(variant.id);
                          final cartItem = cartState.getItem(variant.id);

                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceVariant
                                  .withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isInCart
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.outline,
                                width: isInCart ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        variant.weight,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            variant.price,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                            ),
                                          ),
                                          if (variant.originalPrice !=
                                              variant.price) ...[
                                            const SizedBox(width: 8),
                                            Text(
                                              variant.originalPrice,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurfaceVariant,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ],
                                          if (variant.discount != null &&
                                              variant.discount!.isNotEmpty) ...[
                                            const SizedBox(width: 8),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                variant.discount!,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                if (isInCart)
                                  _buildVariantQuantitySelector(
                                      context, cartItem!)
                                else
                                  _buildVariantAddButton(context, variant),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildVariantAddButton(
      BuildContext context, ProductVariant variant) {
    return GestureDetector(
      onTap: () {
        final cartItem = CartItem(
          id: variant.id,
          productId: product.id,
          name: product.name,
          weight: variant.weight,
          price: variant.price,
          originalPrice: variant.originalPrice,
          discount: variant.discount,
        );
        context.read<CartCubit>().addItem(cartItem);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: context.appColors.primary),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: context.appColors.primary, size: 16),
            const SizedBox(width: 4),
            Text(
              'Add',
              style: TextStyle(
                color: context.appColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVariantQuantitySelector(
      BuildContext context, CartItem cartItem) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: context.appColors.primary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              context.read<CartCubit>().removeItem(cartItem.id);
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              child: Icon(
                Icons.remove,
                color: context.appColors.onPrimary,
                size: 16,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '${cartItem.quantity}',
              style: TextStyle(
                color: context.appColors.onPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<CartCubit>().addItem(cartItem);
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              child: Icon(
                Icons.add,
                color: context.appColors.onPrimary,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}