
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/features/store/presentation/widgets/category_filter_chip.dart';
import 'package:flutter/material.dart';

class CategoryFilterBar extends StatelessWidget {
  final List<CategoryFilter>? categories;

  const CategoryFilterBar({super.key, this.categories});

  @override
  Widget build(BuildContext context) {
    final defaultCategories = categories ?? [
      CategoryFilter('Vegetables & Fruits', false),
      CategoryFilter('Dairy, Bread & Egg', true),
      // CategoryFilter('Biscuit', false),
    ];

    return SliverToBoxAdapter(
      child: Container(
        color: context.appColors.surface,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: defaultCategories
              .map((category) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CategoryFilterChip(
                      label: category.name,
                      isSelected: category.isSelected,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}


class CategoryFilter {
  final String name;
  final bool isSelected;

  CategoryFilter(this.name, this.isSelected);
}