import 'package:customer_app/features/home/presentation/cubit/cart/cart_cubit.dart';
import 'package:customer_app/features/home/widgets/cart_bottom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_state.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  // Custom App Bar
                  Container(
                    height: MediaQuery.of(context).padding.top + 60,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Text(
                                'Product name',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Handle share action
                              },
                              child: const Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Content
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Image
                            Center(
                              child: Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[100],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    'assets/images/amul_masti_curd.png', // You'll need to add this image
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const Icon(
                                          Icons.image,
                                          size: 80,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Product Name
                            const Text(
                              'Amul Masti Pouch Curd',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),

                            const SizedBox(height: 4),

                            // Pack Info
                            Text(
                              'Pack of 3',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Price and Add Button Row
                            Row(
                              children: [
                                BlocBuilder<CartCubit, CartState>(
                                  builder: (context, cartState) {
                                    final cartItem =
                                        cartState.getItem('amul_masti_curd');
                                    final isInCart = cartItem != null;

                                    if (isInCart) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xFF8B5CF6)),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<CartCubit>()
                                                    .removeItem(
                                                        'amul_masti_curd');
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: Color(0xFF8B5CF6),
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
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
                                                context
                                                    .read<CartCubit>()
                                                    .addItem(
                                                      CartItem(
                                                        id: 'amul_masti_curd',
                                                        productId:
                                                            'amul_masti_curd',
                                                        name:
                                                            'Amul Masti Pouch Curd',
                                                        weight: 'Pack of 3',
                                                        price: '70',
                                                        originalPrice: '140',
                                                        discount: '50%',
                                                      ),
                                                    );
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
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
                                                  id: 'amul_masti_curd',
                                                  productId: 'amul_masti_curd',
                                                  name: 'Amul Masti Pouch Curd',
                                                  weight: 'Pack of 3',
                                                  price: '70',
                                                  originalPrice: '140',
                                                  discount: '50%',
                                                ),
                                              );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xFF8B5CF6)),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 10),
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
                                ),

                                const Spacer(),

                                // Price
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          '₹70',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '₹140',
                                          style: TextStyle(
                                            fontSize: 14,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 32),

                            // Product Details Section
                            const Text(
                              'Product Details',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),

                            const SizedBox(height: 12),

                            Text(
                              'Delicious and nutritious, Amul Dahi (Polypack) makes for an ideal meal- time accompaniment. Made from pasteurised toned milk, it can be used in the preparation of Lassi, Dahi Wada, Mugiai Food, etc. and to marinate a wide variety of veg and non-veg dishes.',
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                color: Colors.grey[700],
                              ),
                            ),

                            const SizedBox(height: 16),

                            GestureDetector(
                              onTap: () {
                                // Handle view more
                              },
                              child: const Text(
                                'View more...',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF8B5CF6),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            const SizedBox(height: 32),

                            // Review Section
                            const Text(
                              'Review',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),

                            const SizedBox(height: 12),

                            Row(
                              children: [
                                // Star Rating
                                Row(
                                  children: List.generate(5, (index) {
                                    return const Icon(
                                      Icons.star,
                                      color: Colors.green,
                                      size: 20,
                                    );
                                  }),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  '4.5/5',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '(1150)',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 100), // Bottom padding
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: const CartBottomWidget(),
              ),
            ],
          ),
        );
      },
    );
  }
}
