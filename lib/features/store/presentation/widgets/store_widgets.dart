// ignore_for_file: deprecated_member_use

import 'package:customer_app/constants/app_icons.dart';
import 'package:customer_app/constants/app_images.dart';
import 'package:customer_app/constants/app_route_constants.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_cubit.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class StoreWidgets {
  StoreWidgets._();

  static Widget appBar(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [appBarContent(context), cloudImage(context)],
      ),
    );
  }

  static Widget appBarContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appColors.primary,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: const EdgeInsets.all(12),
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
                    color: context.appColors.onSurface,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Store Name,Chennai',
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: context.appColors.onPrimary,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          Image.asset(
                            AppIcons.shoppingBag,
                            color: context.appColors.onPrimary,
                            height: 16,
                          ),
                          const SizedBox(width: 5),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Free delivery',
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: context.appColors.onPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Image.asset(
                            AppIcons.timing,
                            color: context.appColors.onPrimary,
                            height: 20,
                          ),
                          const SizedBox(width: 5),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '10-15',
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: context.appColors.onPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 50,
                width: 50,
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
                  Icons.person,
                  color: context.appColors.onSurfaceVariant,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget cloudImage(BuildContext context) {
    return Image.asset(
      AppImages.cloudAppBar,
      width: double.infinity,
      color: context.appColors.primary,
      fit: BoxFit.cover,
    );
  }

  static Widget searchBar(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                  color: context.appColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.appColors.outline),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search items',
                    hintStyle: TextStyle(
                        color: context.appColors.onSurfaceVariant,
                        fontSize: 16),
                    prefixIcon: Icon(Icons.search,
                        color: context.appColors.onSurfaceVariant),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () => _showFilterBottomSheet(context),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: context.appColors.primary, 
                      shape: BoxShape.circle),
                  child: Center(
                    child: Image.asset(
                      fit: BoxFit.cover, 
                      AppIcons.filterList
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

static void _showFilterBottomSheet(BuildContext context) {
  final cartCubit = context.read<CartCubit>();
  
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return BlocProvider<CartCubit>.value(
        value: cartCubit,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 20),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filter',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Filter content
              Expanded(
                child: _buildFilterContent(context),
              ),
              // Bottom buttons
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          context.read<CartCubit>().resetFilters();
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: Theme.of(context).colorScheme.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Reset',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<CartCubit>().applyFilters();
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Apply Filter',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

static Widget _buildFilterContent(BuildContext context) {
  final filterSections = [
    {
      'title': 'Category',
      'options': ['Grocery', 'Electronics', 'Bakery', 'Medicine'],
    },
    {
      'title': 'Price Range',
      'options': ['Under ₹100', '₹100 - ₹500', '₹500 - ₹1000', 'Above ₹1000'],
    },
    {
      'title': 'Brand',
      'options': ['Amul', 'Mother Dairy', 'Nestle', 'Britannia'],
    },
    {
      'title': 'Discount',
      'options': ['10% or more', '20% or more', '30% or more', '50% or more'],
    },
  ];

  return BlocConsumer<CartCubit, CartState>(
    listener: (context, state) {
    },
    builder: (context, state) {
      if (state.selectedOptions.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            context.read<CartCubit>().initializeFilters(filterSections);
          }
        });
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading filters...'),
            ],
          ),
        );
      }

      return Row(
        children: [
          // Left side - Sections
          Container(
            width: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              border: Border(
                right: BorderSide(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                  width: 1,
                ),
              ),
            ),
            child: ListView.builder(
              itemCount: filterSections.length,
              itemBuilder: (context, index) {
                final section = filterSections[index];
                final sectionTitle = section['title'] as String;
                final isSelected = state.selectedSectionIndex == index;

                return GestureDetector(
                  onTap: () {
                    context.read<CartCubit>().selectSection(index);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.surface
                          : Colors.transparent,
                      border: isSelected
                          ? Border(
                              left: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 3,
                              ),
                            )
                          : null,
                    ),
                    child: Row(
                      children: [
                        if (isSelected)
                          Container(
                            width: 4,
                            height: 4,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        Expanded(
                          child: Text(
                            sectionTitle,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              color: isSelected
                                  ? Theme.of(context).colorScheme.onSurface
                                  : Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Right side - Options
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Builder(
                builder: (context) {
                  if (state.selectedSectionIndex >= filterSections.length ||
                      state.selectedSectionIndex < 0) {
                    return const Center(child: Text('Invalid section selected'));
                  }
                  
                  final currentSection = filterSections[state.selectedSectionIndex];
                  final sectionTitle = currentSection['title'] as String;
                  final options = currentSection['options'] as List<String>;
                  
                  if (!state.selectedOptions.containsKey(sectionTitle) ||
                      state.selectedOptions[sectionTitle]!.length != options.length) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 8),
                          Text('Loading options...'),
                        ],
                      ),
                    );
                  }

                  final sectionOptions = state.selectedOptions[sectionTitle]!;

                  return ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      if (index >= options.length || index >= sectionOptions.length) {
                        return const SizedBox.shrink();
                      }

                      final option = options[index];
                      final isSelected = sectionOptions[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            Checkbox(
                              value: isSelected,
                              onChanged: (bool? value) {
                                context.read<CartCubit>().toggleOption(sectionTitle, index);
                              },
                              activeColor: Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                option,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      );
    },
  );
}

  static Widget categoryTabs(BuildContext context) {
    final categories = [
      {
        'name': 'All',
        'icon': Icons.star,
      },
      {
        'name': 'Grocery',
        'icon': Icons.shopping_basket,
      },
      {
        'name': 'Electronics',
        'icon': Icons.headphones,
      },
      {
        'name': 'Bakery',
        'icon': Icons.cake,
      },
      {
        'name': 'Medicine',
        'icon': Icons.local_pharmacy,
      },
    ];

    return SliverToBoxAdapter(
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final isSelected = index == 0;

            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: InkWell(
                onTap: () {
                  final cartCubit = context.read<CartCubit>();
                  context.goNamed(
                    AppRoutes.groceryStoreScreen,
                    extra: cartCubit,
                  );
                },
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? context.appColors.primary
                              : context.appColors.outline,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        category['icon'] as IconData,
                        color: isSelected
                            ? context.appColors.primary
                            : context.appColors.onSurfaceVariant,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category['name'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected
                            ? context.appColors.onSurface
                            : context.appColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static Widget offerProducts(BuildContext context) {
    final products = [
      {
        'id': 'product_1',
        'name': 'Amul Masti Pouch Curd',
        'weight': '500 gm',
        'price': '₹70',
        'originalPrice': '₹140',
        'discount': '50% Off',
      },
      {
        'id': 'product_2',
        'name': 'Mother Dairy Classic Cup Curd',
        'weight': '400 gm',
        'price': '₹30',
        'originalPrice': '₹60',
        'discount': '50% Off',
      },
      {
        'id': 'product_3',
        'name': 'Amul Masti Pouch Curd',
        'weight': '500 gm',
        'price': '₹70',
        'originalPrice': '₹140',
        'discount': '50% Off',
      },
    ];

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Offer Products',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.appColors.onSurface,
              ),
            ),
          ),
          SizedBox(
            height: 290,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return _buildProductCard(context, product);
              },
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildProductCard(
      BuildContext context, Map<String, dynamic> product) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, cartState) {
        final isInCart = cartState.isItemInCart(product['id'] as String);
        final cartItem = cartState.getItem(product['id'] as String);

        return Container(
          width: 160,
          margin: const EdgeInsets.only(right: 12),
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
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: context.appColors.surfaceVariant,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: context.appColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        product['discount'] as String,
                        style: TextStyle(
                          color: context.appColors.onPrimary,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: context.appColors.onSurface,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product['weight'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.appColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          product['price'] as String,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: context.appColors.onSurface,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          product['originalPrice'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: context.appColors.onSurfaceVariant,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: isInCart
                          ? _buildQuantitySelector(context, cartItem!)
                          : _buildAddButton(context, product),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildAddButton(
      BuildContext context, Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        final cartItem = CartItem(
          id: product['id'] as String,
          productId: product['id'] as String,
          name: product['name'] as String,
          weight: product['weight'] as String,
          price: product['price'] as String,
          originalPrice: product['originalPrice'] as String,
          discount: product['discount'] as String,
        );
        context.read<CartCubit>().addItem(cartItem);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: context.appColors.primary),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: context.appColors.primary, size: 16),
            const SizedBox(width: 4),
            Text(
              'Add',
              style: TextStyle(
                color: context.appColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildQuantitySelector(
      BuildContext context, CartItem cartItem) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: context.appColors.primary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              context.read<CartCubit>().removeItem(cartItem.id);
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              child: Icon(
                Icons.remove,
                color: context.appColors.onPrimary,
                size: 16,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '${cartItem.quantity}',
              style: TextStyle(
                color: context.appColors.onPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<CartCubit>().addItem(cartItem);
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              child: Icon(
                Icons.add,
                color: context.appColors.onPrimary,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget productCategory(
      BuildContext context, String title, List<Map<String, dynamic>> items) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: context.appColors.onSurface,
                  ),
                ),
                Text(
                  'View all',
                  style: TextStyle(
                    fontSize: 14,
                    color: context.appColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: items.length > 8 ? 8 : items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: context.appColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['name'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: context.appColors.onSurface,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  static Widget dairyBreadEgg(BuildContext context) {
    final items = [
      {'name': 'Milk'},
      {'name': 'Yogurt & Curd'},
      {'name': 'Cheese'},
      {'name': 'Butter & Margarine'},
      {'name': 'Cream & Ghee'},
      {'name': 'Bread'},
      {'name': 'Eggs'},
    ];

    return productCategory(context, 'Dairy, Bread & Egg', items);
  }

  static Widget vegetablesFruits(BuildContext context) {
    final items = [
      {'name': 'Citrus Fruits'},
      {'name': 'Berries'},
      {'name': 'Melons'},
      {'name': 'Tropical Fruits'},
      {'name': 'Leafy Vegetables'},
      {'name': 'Root Vegetables'},
      {'name': 'Gourds & Squash'},
    ];

    return productCategory(context, 'Vegetables & Fruits', items);
  }
}