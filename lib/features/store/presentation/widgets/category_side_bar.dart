
import 'package:customer_app/features/store/presentation/widgets/category_item_widget.dart';
import 'package:flutter/material.dart';

class CategorySidebar extends StatelessWidget {
  final List<CategoryItem>? categories;

  const CategorySidebar({super.key, this.categories});

  @override
  Widget build(BuildContext context) {
    final defaultCategories = categories ?? [
      CategoryItem('🥛', 'Milk', true),
      CategoryItem('🧀', 'Yogurt\n& Curd'),
      CategoryItem('🧈', 'Butter &\nMargarine'),
      CategoryItem('🍯', 'Cream\n& Ghee'),
      CategoryItem('🍞', 'Bread'),
      CategoryItem('🥚', 'Eggs'),
    ];

    return Container(
      width: 76,
      padding: const EdgeInsets.only(left: 16, top: 16),
      child: Column(
        children: defaultCategories
            .map((category) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CategoryItemWidget(
                    emoji: category.emoji,
                    name: category.name,
                    isSelected: category.isSelected,
                  ),
                ))
            .toList(),
      ),
    );
  }
}


class CategoryItem {
  final String emoji;
  final String name;
  final bool isSelected;

  CategoryItem(this.emoji, this.name, [this.isSelected = false]);
}