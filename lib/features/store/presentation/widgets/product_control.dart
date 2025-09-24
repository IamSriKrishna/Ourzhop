
import 'package:customer_app/features/home/presentation/cubit/cart/cart_cubit.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_state.dart';
import 'package:customer_app/features/home/presentation/models/product_model.dart';
import 'package:customer_app/features/store/presentation/widgets/quantity_control.dart';
import 'package:customer_app/features/store/presentation/widgets/varient_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductControls extends StatelessWidget {
  final Product product;

  const ProductControls({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, cartState) {
        final selectedVariantId = cartState.getSelectedVariant(product.id);

        if (product.variants.length > 1 && selectedVariantId == null) {
          return VariantSelector(product: product);
        }

        return QuantityControls(product: product);
      },
    );
  }
}