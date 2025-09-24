
import 'package:customer_app/features/home/presentation/cubit/cart/cart_cubit.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_state.dart';
import 'package:customer_app/features/home/presentation/models/product_model.dart';
import 'package:customer_app/features/store/presentation/widgets/add_to_cart_button.dart';
import 'package:customer_app/features/store/presentation/widgets/quantity_adjuster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuantityControls extends StatelessWidget {
  final Product product;

  const QuantityControls({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, cartState) {
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

        return AddToCartButton(
          onTap: () {
            final variant =
                product.variants.firstWhere((v) => v.id == selectedVariantId);
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
      },
    );
  }
}