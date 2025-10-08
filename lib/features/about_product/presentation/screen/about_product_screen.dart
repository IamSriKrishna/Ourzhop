import 'package:customer_app/features/about_product/presentation/widgets/product_addt_to_cart_button.dart';
import 'package:customer_app/features/about_product/presentation/widgets/product_app_bar.dart';
import 'package:customer_app/features/about_product/presentation/widgets/product_detail_section.dart';
import 'package:customer_app/features/about_product/presentation/widgets/product_image_widget.dart';
import 'package:customer_app/features/about_product/presentation/widgets/product_price_widget.dart';
import 'package:customer_app/features/about_product/presentation/widgets/product_review_section.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_cubit.dart';
import 'package:customer_app/features/home/widgets/cart_bottom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_state.dart';

class AboutProductScreen extends StatelessWidget {
  const AboutProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  ProductAppBar(
                    title: 'Product name',
                    onShare: () {},
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ProductImageWidget(
                              imagePath: 'assets/images/amul_masti_curd.png',
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'Amul Masti Pouch Curd',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Pack of 3',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                AddToCartButton(
                                  productId: 'amul_masti_curd',
                                  name: 'Amul Masti Pouch Curd',
                                  weight: 'Pack of 3',
                                  price: '70',
                                  originalPrice: '140',
                                  discount: '50%',
                                ),
                                const Spacer(),
                                const ProductPriceWidget(
                                  price: '70',
                                  originalPrice: '140',
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            ProductDetailsSection(
                              description:
                                  'Delicious and nutritious, Amul Dahi (Polypack) makes for an ideal meal- time accompaniment. Made from pasteurised toned milk, it can be used in the preparation of Lassi, Dahi Wada, Mugiai Food, etc. and to marinate a wide variety of veg and non-veg dishes.',
                              onViewMore: () {},
                            ),
                            const SizedBox(height: 32),
                            const ProductReviewSection(
                              rating: 4.5,
                              totalReviews: 1150,
                            ),
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: CartBottomWidget(),
              ),
            ],
          ),
        );
      },
    );
  }
}
