// ignore_for_file: deprecated_member_use

import 'package:customer_app/constants/app_icons.dart';
import 'package:customer_app/constants/app_images.dart';
import 'package:customer_app/constants/app_route_constants.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_cubit.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_state.dart';
import 'package:customer_app/features/store/data/model/product_model.dart';
import 'package:customer_app/features/store/presentation/bloc/product_bloc.dart';
import 'package:customer_app/features/store/presentation/bloc/product_event.dart';
import 'package:customer_app/features/store/presentation/bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

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
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
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
                            color: context.appColors.outline
                                .withValues(alpha: 0.2),
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
                            'Store Name',
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
                          color:
                              context.appColors.outline.withValues(alpha: 0.1),
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
      },
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
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () => _showFilterBottomSheet(context),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: context.appColors.primary,
                          shape: BoxShape.circle),
                      child: Center(
                        child:
                            Image.asset(fit: BoxFit.cover, AppIcons.filterList),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  static void _showFilterBottomSheet(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final productBloc = context.read<ProductBloc>();
    final productState = productBloc.state;

    // Check if filters are available
    if (productState is! ProductSuccess || productState.filters == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Filters not available'),
          backgroundColor: context.appColors.error,
        ),
      );
      return;
    }

    final filters = productState.filters!;

    // Build filter sections from API data
    final filterSections = <Map<String, dynamic>>[];

    // Categories
    if (filters.categories.isNotEmpty) {
      filterSections.add({
        'title': 'Category',
        'key': 'categories',
        'options': filters.categories.map((c) => c.name).toList(),
        'ids': filters.categories.map((c) => c.id).toList(),
      });
    }

    // Brands
    if (filters.brands.isNotEmpty) {
      filterSections.add({
        'title': 'Brand',
        'key': 'brands',
        'options': filters.brands.map((b) => b.name).toList(),
        'ids': filters.brands.map((b) => b.id).toList(),
      });
    }

    // Price Range
    filterSections.add({
      'title': 'Price Range',
      'key': 'price_range',
      'options': [
        'Under ₹${filters.priceRange.minPrice.toStringAsFixed(0)}',
        '₹${filters.priceRange.minPrice.toStringAsFixed(0)} - ₹${((filters.priceRange.minPrice + filters.priceRange.maxPrice) / 2).toStringAsFixed(0)}',
        '₹${((filters.priceRange.minPrice + filters.priceRange.maxPrice) / 2).toStringAsFixed(0)} - ₹${filters.priceRange.maxPrice.toStringAsFixed(0)}',
        'Above ₹${filters.priceRange.maxPrice.toStringAsFixed(0)}',
      ],
      'ids': ['under', 'mid', 'high', 'above'],
    });

    // Dietary Types
    if (filters.dietaryTypes.isNotEmpty) {
      filterSections.add({
        'title': 'Dietary Type',
        'key': 'dietary_types',
        'options': filters.dietaryTypes.map((d) => d.name).toList(),
        'ids': filters.dietaryTypes.map((d) => d.id).toList(),
      });
    }

    // Has Discounts
    if (filters.hasDiscounts) {
      filterSections.add({
        'title': 'Discount',
        'key': 'discount',
        'options': ['Products with discount'],
        'ids': ['has_discount'],
      });
    }

    if (filterSections.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('No filters available'),
          backgroundColor: context.appColors.error,
        ),
      );
      return;
    }

    // Initialize filters
    cartCubit.initializeFilters(filterSections);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext sheetContext) {
        return BlocProvider<CartCubit>.value(
          value: cartCubit,
          child: BlocProvider<ProductBloc>.value(
            value: productBloc,
            child: Container(
              height: MediaQuery.of(sheetContext).size.height * 0.7,
              decoration: BoxDecoration(
                color: Theme.of(sheetContext).colorScheme.surface,
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
                      color: Theme.of(sheetContext).colorScheme.outline,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Filter',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(sheetContext)
                                    .colorScheme
                                    .onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${filters.totalProducts} products available',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(sheetContext)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(sheetContext).pop(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(sheetContext)
                                  .colorScheme
                                  .surfaceVariant,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              color: Theme.of(sheetContext)
                                  .colorScheme
                                  .onSurfaceVariant,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: _buildFilterContent(sheetContext, filterSections),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(sheetContext).colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(sheetContext)
                              .colorScheme
                              .outline
                              .withOpacity(0.1),
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
                              cartCubit.resetFilters();
                              productBloc.add(ResetFiltersEvent());
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(
                                  color: Theme.of(sheetContext)
                                      .colorScheme
                                      .primary),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Reset',
                              style: TextStyle(
                                color:
                                    Theme.of(sheetContext).colorScheme.primary,
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
                              cartCubit.applyFilters();

                              // Convert CartCubit filters to ProductBloc format
                              final selectedFilters = <String, List<String>>{};
                              final cartState = cartCubit.state;

                              cartState.selectedOptions.forEach((key, values) {
                                final section = filterSections.firstWhere(
                                  (s) => s['title'] == key,
                                  orElse: () => {},
                                );

                                if (section.isNotEmpty) {
                                  final sectionKey = section['key'] as String;
                                  final ids = section['ids'] as List<String>;
                                  final selectedIds = <String>[];

                                  for (int i = 0; i < values.length; i++) {
                                    if (values[i] && i < ids.length) {
                                      selectedIds.add(ids[i]);
                                    }
                                  }

                                  if (selectedIds.isNotEmpty) {
                                    selectedFilters[sectionKey] = selectedIds;
                                  }
                                }
                              });

                              productBloc.add(ApplyFiltersEvent(
                                selectedFilters: selectedFilters,
                              ));

                              Navigator.of(sheetContext).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(sheetContext).colorScheme.primary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Apply Filter',
                              style: TextStyle(
                                color: Theme.of(sheetContext)
                                    .colorScheme
                                    .onPrimary,
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
          ),
        );
      },
    );
  }

  static Widget _buildFilterContent(
    BuildContext context,
    List<Map<String, dynamic>> filterSections,
  ) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state.selectedOptions.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Row(
          children: [
            // Left side - Sections
            Container(
              width: 120,
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceVariant
                    .withOpacity(0.3),
                border: Border(
                  right: BorderSide(
                    color:
                        Theme.of(context).colorScheme.outline.withOpacity(0.2),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
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
                      child: Text(
                        sectionTitle,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w400,
                          color: isSelected
                              ? Theme.of(context).colorScheme.onSurface
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
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
                      return const Center(
                          child: Text('Invalid section selected'));
                    }

                    final currentSection =
                        filterSections[state.selectedSectionIndex];
                    final sectionTitle = currentSection['title'] as String;
                    final options = currentSection['options'] as List<String>;

                    if (!state.selectedOptions.containsKey(sectionTitle)) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final sectionOptions = state.selectedOptions[sectionTitle]!;

                    return ListView.builder(
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        if (index >= options.length ||
                            index >= sectionOptions.length) {
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
                                  context
                                      .read<CartCubit>()
                                      .toggleOption(sectionTitle, index);
                                },
                                activeColor:
                                    Theme.of(context).colorScheme.primary,
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
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
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
            );
          },
        ),
      ),
    );
  }

  static Widget offerProducts(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        Logger().e("Product State: $state");
        Logger().e("State Type: ${state.runtimeType}");

        if (state is ProductInitial) {
          Logger().w("State is ProductInitial - no products loaded yet");
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        if (state is ProductLoading) {
          Logger().i("Loading products...");
          return SliverToBoxAdapter(
            child: Container(
              height: 290,
              padding: const EdgeInsets.all(16),
              child: const Center(child: CircularProgressIndicator()),
            ),
          );
        }

        if (state is ProductError) {
          Logger().e("Product Error: ${state.message}");
          return SliverToBoxAdapter(
            child: Container(
              height: 200,
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: context.appColors.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: TextStyle(
                        fontSize: 14,
                        color: context.appColors.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (state is ProductEmpty) {
          Logger().w("No products available");
          return SliverToBoxAdapter(
            child: Container(
              height: 200,
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  'No products available',
                  style: TextStyle(
                    fontSize: 16,
                    color: context.appColors.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          );
        }

        if (state is ProductSuccess) {
          Logger()
              .i("ProductSuccess - Total products: ${state.products.length}");

          // Just show all products - remove the discount filter
          final productsToShow = state.products;

          if (productsToShow.isEmpty) {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }

          return SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Products',
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
                    itemCount: productsToShow.length,
                    itemBuilder: (context, index) {
                      final product = productsToShow[index];
                      return _buildProductCard(context, product);
                    },
                  ),
                ),
              ],
            ),
          );
        }

        Logger().w("Unknown state: $state");
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }

  static Widget _buildProductCard(BuildContext context, ProductModel product) {
    // Get the first variant (or cheapest variant)
    final variant = product.variants.isNotEmpty
        ? product.variants
            .reduce((a, b) => a.sellingPrice < b.sellingPrice ? a : b)
        : null;

    if (variant == null) return const SizedBox.shrink();

    // Check if product has multiple variants
    final hasMultipleVariants = product.hasVariants && product.variantCount > 1;

    final discountPercentage = variant.discountPercentage > 0
        ? '${variant.discountPercentage}% Off'
        : null;

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, cartState) {
        final isInCart = cartState.isItemInCart(variant.productVariantId);
        final cartItem = cartState.getItem(variant.productVariantId);

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
                      image: product.primaryImage.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(product.primaryImage),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: product.primaryImage.isEmpty
                        ? Icon(
                            Icons.image_not_supported,
                            size: 48,
                            color: context.appColors.onSurfaceVariant,
                          )
                        : null,
                  ),
                  if (discountPercentage != null)
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
                          discountPercentage,
                          style: TextStyle(
                            color: context.appColors.onPrimary,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  if (!variant.inStock)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Out of Stock',
                            style: TextStyle(
                              color: context.appColors.surface,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
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
                      product.name,
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
                      '${variant.unitValue} ${product.unitName}',
                      style: TextStyle(
                        fontSize: 12,
                        color: context.appColors.onSurfaceVariant,
                      ),
                    ),
                    if (product.brand.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        product.brand,
                        style: TextStyle(
                          fontSize: 11,
                          color: context.appColors.onSurfaceVariant,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    // Show price range if multiple variants, else single price
                    if (hasMultipleVariants)
                      Row(
                        children: [
                          Text(
                            '₹${product.priceRange.minPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: context.appColors.onSurface,
                            ),
                          ),
                          Text(
                            ' - ₹${product.priceRange.maxPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: context.appColors.onSurface,
                            ),
                          ),
                        ],
                      )
                    else
                      Row(
                        children: [
                          Text(
                            '₹${variant.sellingPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: context.appColors.onSurface,
                            ),
                          ),
                          if (variant.discountPercentage > 0) ...[
                            const SizedBox(width: 4),
                            Text(
                              '₹${variant.mrp.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: context.appColors.onSurfaceVariant,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ],
                      ),
                    const SizedBox(height: 12),
                    Center(
                      child: variant.inStock
                          ? (hasMultipleVariants
                              ? _buildChooseVariantButton(context, product)
                              : (isInCart
                                  ? _buildQuantitySelector(context, cartItem!)
                                  : _buildAddButton(context, product, variant)))
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              decoration: BoxDecoration(
                                color: context.appColors.surfaceVariant,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Notify Me',
                                style: TextStyle(
                                  color: context.appColors.onSurfaceVariant,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
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

  static Widget _buildChooseVariantButton(
    BuildContext context,
    ProductModel product,
  ) {
    return GestureDetector(
      onTap: () {
        _showVariantBottomSheet(context, product);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: context.appColors.primary),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.list_alt, color: context.appColors.primary, size: 16),
            const SizedBox(width: 4),
            Text(
              'Variant',
              style: TextStyle(
                color: context.appColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void _showVariantBottomSheet(
    BuildContext context,
    ProductModel product,
  ) {
    final cartCubit = context.read<CartCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return BlocProvider<CartCubit>.value(
          value: cartCubit,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                // Drag handle
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 20),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outline,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (product.brand.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                product.brand,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
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
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Variants list
                Expanded(
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, cartState) {
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: product.variants.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final variant = product.variants[index];
                          final isInCart =
                              cartState.isItemInCart(variant.productVariantId);
                          final cartItem =
                              cartState.getItem(variant.productVariantId);

                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceVariant
                                  .withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isInCart
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.outline,
                                width: isInCart ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${variant.unitValue} ${product.unitName}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            '₹${variant.sellingPrice.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                            ),
                                          ),
                                          if (variant.discountPercentage >
                                              0) ...[
                                            const SizedBox(width: 8),
                                            Text(
                                              '₹${variant.mrp.toStringAsFixed(2)}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurfaceVariant,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                '${variant.discountPercentage}% OFF',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      if (!variant.inStock) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          'Out of Stock',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                if (variant.inStock)
                                  isInCart
                                      ? _buildQuantitySelector(
                                          context, cartItem!)
                                      : _buildAddButton(
                                          context, product, variant),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _buildAddButton(
    BuildContext context,
    ProductModel product,
    ProductVariantModel variant,
  ) {
    return GestureDetector(
      onTap: () {
        final cartItem = CartItem(
          id: variant.productVariantId,
          productId: product.productId,
          name: product.name,
          weight: '${variant.unitValue} ${product.unitName}',
          price: '₹${variant.sellingPrice.toStringAsFixed(2)}',
          originalPrice: '₹${variant.mrp.toStringAsFixed(2)}',
          discount: variant.discountPercentage > 0
              ? '${variant.discountPercentage}% Off'
              : null,
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
                return GestureDetector(
                  onTap: () {
                    final shopId =
                        GoRouterState.of(context).pathParameters['shopId'];

                    if (shopId != null && shopId.isNotEmpty) {
                      context.goNamed(
                        AppRoutes.groceryStoreScreen,
                        pathParameters: {'shopId': shopId},
                      );
                    }
                  },
                  child: Column(
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
                  ),
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
