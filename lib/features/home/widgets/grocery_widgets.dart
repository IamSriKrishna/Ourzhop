import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/features/home/data/models/category_chip.dart';
import 'package:customer_app/features/home/data/models/side_category.dart';
import 'package:customer_app/features/home/presentation/models/product_model.dart';
import 'package:flutter/material.dart';

class GroceryWidgets {
  const GroceryWidgets._();

  static Widget buildAppBar({
    required BuildContext context,
    required String storeName,
    required String location,
    required String deliveryText,
    required String timeAndDistance,
    required VoidCallback onBackPressed,
    required VoidCallback onSearchPressed,
    bool showOnlineStatus = true,
  }) {
    return SliverAppBar(
      toolbarHeight: 80,
      floating: false,
      pinned: true,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: onBackPressed,
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
                '$storeName, $location',
                style: TextStyle(
                  color: context.appColors.onPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (showOnlineStatus) ...[
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
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Icon(Icons.delivery_dining, 
                color: context.appColors.onPrimary, 
                size: 14),
              const SizedBox(width: 4),
              Text(
                deliveryText,
                style: TextStyle(
                  color: context.appColors.onPrimary, 
                  fontSize: 12),
              ),
              const SizedBox(width: 12),
              Icon(Icons.access_time, 
                color: context.appColors.onPrimary, 
                size: 14),
              const SizedBox(width: 4),
              Text(
                timeAndDistance,
                style: TextStyle(
                  color: context.appColors.onPrimary, 
                  fontSize: 12),
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
          child: IconButton(
            onPressed: onSearchPressed,
            icon: Icon(
              Icons.search,
              color: context.appColors.primary,
              size: 20,
            ),
          ),
        )
      ],
      backgroundColor: context.appColors.primary,
      elevation: 0,
    );
  }

  static Widget buildCategoryChips({
    required BuildContext context,
    required List<CategoryChip> categories,
  }) {
    return Container(
      color: context.appColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((category) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: category.onTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: category.isSelected
                        ? context.appColors.primary
                        : context.appColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    category.title,
                    style: TextStyle(
                      color: category.isSelected 
                          ? context.appColors.onPrimary 
                          : context.appColors.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  static Widget buildCategoryItem({
    required BuildContext context,
    required String emoji,
    required String name,
    bool isSelected = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
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
      ),
    );
  }

  static Widget buildProductCard({
    required BuildContext context,
    required Product product,
    required Map<String, String> selectedVariants,
    required Function(Product) onVariantSelected,
    required Widget Function(Product) buildProductControls,
  }) {
    final selectedVariantId = selectedVariants[product.id];
    final selectedVariant = selectedVariantId != null
        ? product.variants.firstWhere((v) => v.id == selectedVariantId)
        : null;

    final displayVariant = selectedVariant ?? product.variants.first;

    return Container(
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
                  child: Text(product.image, style: const TextStyle(fontSize: 40)),
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
          buildProductControls(product),
        ],
      ),
    );
  }

  static Widget buildVariantSelector({
    required BuildContext context,
    required Product product,
    required Function(ProductVariant) onVariantSelected,
  }) {
    return SizedBox(
      height: 32,
      child: PopupMenuButton<ProductVariant>(
        onSelected: onVariantSelected,
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

  static Widget buildQuantityControls({
    required BuildContext context,
    required int quantity,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
    required VoidCallback onAdd,
    String addButtonText = 'Add',
  }) {
    if (quantity > 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onDecrement,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: context.appColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.remove, 
                color: context.appColors.onPrimary, 
                size: 16),
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
            onTap: onIncrement,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: context.appColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, 
                color: context.appColors.onPrimary, 
                size: 16),
            ),
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: onAdd,
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
            Icon(Icons.add, color: context.appColors.primary, size: 16),
            const SizedBox(width: 4),
            Text(
              addButtonText,
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
  }

  static Widget buildProductGrid({
    required List<Product> products,
    required Widget Function(Product) buildProductCard,
  }) {
    return Column(
      children: [
        for (int i = 0; i < products.length; i += 2) ...[
          Row(
            children: [
              Expanded(child: buildProductCard(products[i])),
              const SizedBox(width: 12),
              if (i + 1 < products.length)
                Expanded(child: buildProductCard(products[i + 1]))
              else
                const Expanded(child: SizedBox()),
            ],
          ),
          if (i + 2 < products.length) const SizedBox(height: 16),
        ],
      ],
    );
  }

  static Widget buildSideCategories({
    required List<SideCategory> categories,
  }) {
    return Container(
      width: 76,
      padding: const EdgeInsets.only(left: 16, top: 16),
      child: Column(
        children: categories.map((category) {
          return Column(
            children: [
              buildCategoryItem(
                context: category.context,
                emoji: category.emoji,
                name: category.name,
                isSelected: category.isSelected,
                onTap: category.onTap,
              ),
              const SizedBox(height: 20),
            ],
          );
        }).toList(),
      ),
    );
  }
}