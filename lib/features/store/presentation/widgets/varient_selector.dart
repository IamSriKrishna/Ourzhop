
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_cubit.dart';
import 'package:customer_app/features/home/presentation/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VariantSelector extends StatelessWidget {
  final Product product;

  const VariantSelector({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: PopupMenuButton<ProductVariant>(
        onSelected: (variant) {
          context.read<CartCubit>().selectVariant(product.id, variant.id);
        },
        itemBuilder: (context) => product.variants
            .map((variant) => PopupMenuItem<ProductVariant>(
                  value: variant,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        variant.weight,
                        style: TextStyle(
                          fontSize: 12,
                          color: context.appColors.onSurface,
                        ),
                      ),
                      Text(
                        variant.price,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: context.appColors.onSurface,
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
        child: Container(
          width: double.infinity,
          height: 32,
          decoration: BoxDecoration(
            border: Border.all(color: context.appColors.primary),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Select Size',
                style: TextStyle(
                  color: context.appColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down,
                color: context.appColors.primary,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
