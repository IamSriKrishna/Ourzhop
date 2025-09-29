
import 'package:customer_app/features/home/presentation/cubit/cart/cart_state.dart';
import 'package:flutter/material.dart';

class CartCheckoutBar extends StatelessWidget {
  final CartState cartState;
  final VoidCallback? onCheckout;
  final String buttonText;
  final double discountAmount;
  final EdgeInsets? padding;

  const CartCheckoutBar({
    super.key,
    required this.cartState,
    this.onCheckout,
    this.buttonText = 'Checkout',
    this.discountAmount = 10.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final totalAmount = cartState.totalAmount - discountAmount;

    return Container(
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
       
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onCheckout ?? _defaultCheckoutAction,
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
            '$buttonText  ₹${totalAmount.toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void _defaultCheckoutAction() {
    // Default checkout implementation
    print('Checkout pressed with total: ₹${(cartState.totalAmount - discountAmount).toStringAsFixed(2)}');
  }
}