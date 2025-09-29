import 'package:customer_app/features/cart/presentation/widgets/cart_payment_details.dart';
import 'package:customer_app/features/cart/presentation/widgets/cart_address_section.dart';
import 'package:customer_app/features/cart/presentation/widgets/cart_products_section.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_state.dart';
import 'package:flutter/material.dart';
import 'cart_coupon_section.dart';
import 'cart_delivery_banner.dart';

class CartContent extends StatelessWidget {
  final CartState cartState;
  final EdgeInsets? padding;

  const CartContent({
    super.key,
    required this.cartState,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SliverToBoxAdapter(
      child: Container(
        color: colorScheme.surface,
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CartAddressSection(),
            CartProductsSection(cartState: cartState),
            const CartCouponSection(),
            CartPaymentDetails(cartState: cartState),
            const CartDeliveryBanner(),
          ],
        ),
      ),
    );
  }
}
