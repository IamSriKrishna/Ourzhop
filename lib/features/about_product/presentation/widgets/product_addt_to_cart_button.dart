import 'package:customer_app/features/home/presentation/cubit/cart/cart_cubit.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartButton extends StatelessWidget {
  final String productId;
  final String name;
  final String weight;
  final String price;
  final String originalPrice;
  final String discount;

  const AddToCartButton({
    super.key,
    required this.productId,
    required this.name,
    required this.weight,
    required this.price,
    required this.originalPrice,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, cartState) {
        final cartItem = cartState.getItem(productId);
        final isInCart = cartItem != null;

        if (isInCart) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF8B5CF6)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<CartCubit>().removeItem(productId);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.remove,
                      color: Color(0xFF8B5CF6),
                      size: 18,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Text(
                    '${cartItem.quantity}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF8B5CF6),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<CartCubit>().addItem(
                          CartItem(
                            id: productId,
                            productId: productId,
                            name: name,
                            weight: weight,
                            price: price,
                            originalPrice: originalPrice,
                            discount: discount,
                          ),
                        );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.add,
                      color: Color(0xFF8B5CF6),
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {
              context.read<CartCubit>().addItem(
                    CartItem(
                      id: productId,
                      productId: productId,
                      name: name,
                      weight: weight,
                      price: price,
                      originalPrice: originalPrice,
                      discount: discount,
                    ),
                  );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF8B5CF6)),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add,
                      color: Color(0xFF8B5CF6),
                      size: 18,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Add',
                      style: TextStyle(
                        color: Color(0xFF8B5CF6),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
