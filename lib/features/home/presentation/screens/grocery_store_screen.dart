import 'package:customer_app/constants/app_route_constants.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/features/home/cubit/cart/cart_cubit.dart';
import 'package:customer_app/features/home/cubit/cart/cart_state.dart';
import 'package:customer_app/features/home/presentation/models/product_model.dart';
import 'package:customer_app/features/home/widgets/cart_bottom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GroceryHomePage extends StatefulWidget {
  final CartCubit cartCubit;

  const GroceryHomePage({super.key, required this.cartCubit});

  @override
  State<GroceryHomePage> createState() => _GroceryHomePageState();
}

class _GroceryHomePageState extends State<GroceryHomePage> {
  final List<Product> products = [
    Product(
      id: 'country_delight_1',
      name: 'Country Delight\nGhar Jaisa Cup C...',
      image: '🥛',
      hasDiscount: true,
      discountPercentage: '50% Off',
      variants: [
        ProductVariant(
          id: 'country_delight_250g',
          weight: '250g',
          price: '₹35',
          originalPrice: '₹70',
          discount: '50% Off',
        ),
        ProductVariant(
          id: 'country_delight_500g',
          weight: '500g',
          price: '₹70',
          originalPrice: '₹140',
          discount: '50% Off',
        ),
        ProductVariant(
          id: 'country_delight_1kg',
          weight: '1kg',
          price: '₹130',
          originalPrice: '₹260',
          discount: '50% Off',
        ),
      ],
    ),
    Product(
      id: 'amul_masti_pouch',
      name: 'Amul Masti Pouch\nCurd',
      image: '🥛',
      variants: [
        ProductVariant(
          id: 'amul_pouch_500g',
          weight: '500g',
          price: '₹70',
          originalPrice: '₹140',
        ),
      ],
    ),
    Product(
      id: 'mother_dairy_1',
      name: 'Mother Dairy\nClassic Cup Curd',
      image: '🥛',
      hasDiscount: true,
      discountPercentage: '50% Off',
      variants: [
        ProductVariant(
          id: 'mother_dairy_200g',
          weight: '200g',
          price: '₹25',
          originalPrice: '₹50',
          discount: '50% Off',
        ),
        ProductVariant(
          id: 'mother_dairy_500g',
          weight: '500g',
          price: '₹30',
          originalPrice: '₹60',
          discount: '50% Off',
        ),
        ProductVariant(
          id: 'mother_dairy_1kg',
          weight: '1kg',
          price: '₹55',
          originalPrice: '₹110',
          discount: '50% Off',
        ),
      ],
    ),
    Product(
      id: 'amul_masti_cup',
      name: 'Amul Masti Cup\nCurd',
      image: '🥛',
      variants: [
        ProductVariant(
          id: 'amul_cup_500ml',
          weight: '500ml',
          price: '₹190',
          originalPrice: '₹190',
        ),
        ProductVariant(
          id: 'amul_cup_1ltr',
          weight: '1 ltr (Pack of 2)',
          price: '₹385',
          originalPrice: '₹385',
        ),
      ],
    ),
    Product(
      id: 'nestle_a_plus',
      name: 'Nestle a+\nUnsweetened Gre...',
      image: '🥛',
      variants: [
        ProductVariant(
          id: 'nestle_500g',
          weight: '500g',
          price: '₹385',
          originalPrice: '₹385',
        ),
      ],
    ),
    Product(
      id: 'epigamia_natural',
      name: 'epigamia Natural\nGreek Yogurt',
      image: '🥛',
      variants: [
        ProductVariant(
          id: 'epigamia_500ml',
          weight: '500ml',
          price: '₹190',
          originalPrice: '₹190',
        ),
        ProductVariant(
          id: 'epigamia_1ltr',
          weight: '1 ltr (Pack of 2)',
          price: '₹385',
          originalPrice: '₹385',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.cartCubit,
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  toolbarHeight: 80,
                  floating: false,
                  pinned: true,
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: context.appColors.surface,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: context.appColors.outline.withValues(alpha: 0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: context.appColors.primary,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Store name, Chennai',
                            style: TextStyle(
                              color: context.appColors.onPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.delivery_dining,
                            color: context.appColors.onPrimary,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Free delivery',
                            style: TextStyle(
                              color: context.appColors.onPrimary,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.access_time,
                            color: context.appColors.onPrimary,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '10-15 mins • 6 kms',
                            style: TextStyle(
                              color: context.appColors.onPrimary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: context.appColors.surface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: context.appColors.outline.withValues(alpha: 0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.search,
                        color: context.appColors.primary,
                        size: 20,
                      ),
                    )
                  ],
                  backgroundColor: context.appColors.primary,
                  elevation: 0,
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: context.appColors.surface,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: context.appColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Vegetables & Fruits',
                            style: TextStyle(
                              fontSize: 12,
                              color: context.appColors.onSurfaceVariant,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: context.appColors.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Dairy, Bread & Egg',
                            style: TextStyle(
                              color: context.appColors.onPrimary,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: context.appColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Biscuit',
                            style: TextStyle(
                              fontSize: 12,
                              color: context.appColors.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverFillRemaining(
                  child: Container(
                    color: context.appColors.surface,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 76,
                          padding: const EdgeInsets.only(left: 16, top: 16),
                          child: Column(
                            children: [
                              _buildCategoryItem(context, '🥛', 'Milk', true),
                              const SizedBox(height: 20),
                              _buildCategoryItem(context, '🧀', 'Yogurt\n& Curd'),
                              const SizedBox(height: 20),
                              _buildCategoryItem(context, '🧈', 'Butter &\nMargarine'),
                              const SizedBox(height: 20),
                              _buildCategoryItem(context, '🍯', 'Cream\n& Ghee'),
                              const SizedBox(height: 20),
                              _buildCategoryItem(context, '🍞', 'Bread'),
                              const SizedBox(height: 20),
                              _buildCategoryItem(context, '🥚', 'Eggs'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                            child: Column(
                              children: [
                                for (int i = 0; i < products.length; i += 2) ...[
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildProductCard(context, products[i]),
                                      ),
                                      const SizedBox(width: 12),
                                      if (i + 1 < products.length)
                                        Expanded(
                                          child: _buildProductCard(context, products[i + 1]),
                                        )
                                      else
                                        const Expanded(child: SizedBox()),
                                    ],
                                  ),
                                  if (i + 2 < products.length)
                                    const SizedBox(height: 16),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
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
      ),
    );
  }

  Widget _buildCategoryItem(
    BuildContext context,
    String emoji,
    String name, [
    bool isSelected = false,
  ]) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isSelected 
                ? context.appColors.primary 
                : context.appColors.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: isSelected 
                ? context.appColors.primary 
                : context.appColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, cartState) {
        final selectedVariantId = cartState.getSelectedVariant(product.id);
        final selectedVariant = selectedVariantId != null
            ? product.variants.firstWhere((v) => v.id == selectedVariantId)
            : null;

        final displayVariant = selectedVariant ?? product.variants.first;

        return GestureDetector(
          onTap: () {
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
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 80,
                      decoration: BoxDecoration(
                        color: context.appColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          product.image,
                          style: const TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
                    if (product.hasDiscount && product.discountPercentage != null)
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: context.appColors.primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            product.discountPercentage!,
                            style: TextStyle(
                              color: context.appColors.onPrimary,
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                    color: context.appColors.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  displayVariant.weight,
                  style: TextStyle(
                    fontSize: 10,
                    color: context.appColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      displayVariant.price,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: context.appColors.onSurface,
                      ),
                    ),
                    if (displayVariant.originalPrice != displayVariant.price) ...[
                      const SizedBox(width: 4),
                      Text(
                        displayVariant.originalPrice,
                        style: TextStyle(
                          fontSize: 10,
                          color: context.appColors.onSurfaceVariant,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 12),
                _buildProductControls(context, product, cartState),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductControls(BuildContext context, Product product, CartState cartState) {
    final selectedVariantId = cartState.getSelectedVariant(product.id);

    if (product.variants.length > 1 && selectedVariantId == null) {
      return _buildVariantSelector(context, product);
    }

    return _buildQuantityControls(context, product);
  }

  Widget _buildVariantSelector(BuildContext context, Product product) {
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

  Widget _buildQuantityControls(BuildContext context, Product product) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, cartState) {
        final selectedVariantId = cartState.getSelectedVariant(product.id) ?? 
                                  product.variants.first.id;
        final cartItem = cartState.getItem(selectedVariantId);
        final quantity = cartItem?.quantity ?? 0;

        if (quantity > 0) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  widget.cartCubit.removeItem(selectedVariantId);
                },
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: context.appColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.remove,
                    color: context.appColors.onPrimary,
                    size: 16,
                  ),
                ),
              ),
              Text(
                '$quantity',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: context.appColors.onSurface,
                ),
              ),
              GestureDetector(
                onTap: () {
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
                  widget.cartCubit.addItem(cartItem);
                },
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: context.appColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    color: context.appColors.onPrimary,
                    size: 16,
                  ),
                ),
              ),
            ],
          );
        }

        return GestureDetector(
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
            widget.cartCubit.addItem(cartItem);
          },
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
                Icon(
                  Icons.add,
                  color: context.appColors.primary,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  'Add',
                  style: TextStyle(
                    color: context.appColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}