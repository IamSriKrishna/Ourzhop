
import 'package:customer_app/constants/app_route_constants.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_cubit.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_state.dart';
import 'package:customer_app/features/home/presentation/models/product_model.dart';
import 'package:customer_app/features/store/presentation/widgets/product_control.dart';
import 'package:customer_app/features/store/presentation/widgets/product_image_section.dart';
import 'package:customer_app/features/store/presentation/widgets/product_info_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, cartState) {
        final selectedVariantId = cartState.getSelectedVariant(product.id);
        final selectedVariant = selectedVariantId != null
            ? product.variants.firstWhere((v) => v.id == selectedVariantId)
            : null;

        final displayVariant = selectedVariant ?? product.variants.first;

        return GestureDetector(
          onTap: onTap ?? () {
            final cartCubit = context.read<CartCubit>();
            context.goNamed(
              AppRoutes.productScreen,
              extra: cartCubit,
            );
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.appColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: context.appColors.outline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductImageSection(
                  image: product.image,
                  hasDiscount: product.hasDiscount,
                  discountPercentage: product.discountPercentage,
                ),
                const SizedBox(height: 8),
                ProductInfoSection(
                  name: product.name,
                  weight: displayVariant.weight,
                  price: displayVariant.price,
                  originalPrice: displayVariant.originalPrice,
                ),
                const SizedBox(height: 12),
                ProductControls(product: product),
              ],
            ),
          ),
        );
      },
    );
  }
}