// ignore_for_file: deprecated_member_use

import 'package:customer_app/constants/app_icons.dart';
import 'package:customer_app/constants/app_images.dart';
import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.primary,
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
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
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
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          Image.asset(
                            AppIcons.shoppingBag,
                            color: Colors.white,
                            height: 16,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Free delivery',
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Image.asset(
                            AppIcons.timing,
                            color: Colors.white,
                            height: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '10-15',
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
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
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.black54,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget cloudImage(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Image.asset(
      AppImages.cloudAppBar,
      width: double.infinity,
      color: colorScheme.primary,
      fit: BoxFit.cover,
    );
  }

  static Widget searchBar(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search items',
              hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16),
              prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
              suffixIcon: Icon(Icons.tune, color: Colors.grey[600]),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
      ),
    );
  }

  static Widget categoryTabs(BuildContext context) {
    final categories = [
      {'name': 'All', 'icon': Icons.star, 'color': Colors.purple},
      {'name': 'Grocery', 'icon': Icons.shopping_basket, 'color': Colors.green},
      {'name': 'Electronics', 'icon': Icons.headphones, 'color': Colors.blue},
      {'name': 'Bakery', 'icon': Icons.cake, 'color': Colors.orange},
      {'name': 'Medicine', 'icon': Icons.local_pharmacy, 'color': Colors.red},
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
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: index == 0
                          ? category['color'] as Color
                          : Colors.grey[100],
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: index == 0
                            ? category['color'] as Color
                            : Colors.grey[300]!,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      category['icon'] as IconData,
                      color: index == 0 ? Colors.white : Colors.grey[600],
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category['name'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight:
                          index == 0 ? FontWeight.w600 : FontWeight.w400,
                      color: index == 0 ? Colors.black : Colors.grey[600],
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
    final products = [
      {
        'name': 'Amul Masti Pouch Curd',
        'weight': '500 gm',
        'price': '₹70',
        'originalPrice': '₹140',
        'discount': '50% Off',
        'color': Colors.green,
      },
      {
        'name': 'Mother Dairy Classic Cup Curd',
        'weight': '400 gm',
        'price': '₹30',
        'originalPrice': '₹60',
        'discount': '50% Off',
        'color': Colors.blue,
      },
      {
        'name': 'Amul Masti Pouch Curd',
        'weight': '500 gm',
        'price': '₹70',
        'originalPrice': '₹140',
        'discount': '50% Off',
        'color': Colors.green,
      },
    ];

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Offer Products',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
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
                return Container(
                  width: 160,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
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
                              color: Colors.grey[100],
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
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                product['discount'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
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
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product['weight'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  product['price'] as String,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  product['originalPrice'] as String,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 6),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.purple),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(Icons.add,
                                        color: Colors.purple, size: 16),
                                    SizedBox(width: 4),
                                    Text(
                                      'Add',
                                      style: TextStyle(
                                        color: Colors.purple,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
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
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'View all',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.purple,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              padding: EdgeInsets.all(0),
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
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['name'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
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
      {'name': 'Milk', 'color': Colors.blue[200]!},
      {'name': 'Yogurt & Curd', 'color': Colors.orange[200]!},
      {'name': 'Cheese', 'color': Colors.yellow[600]!},
      {'name': 'Butter & Margarine', 'color': Colors.yellow[300]!},
      {'name': 'Cream & Ghee', 'color': Colors.yellow[200]!},
      {'name': 'Bread', 'color': Colors.orange[300]!},
      {'name': 'Eggs', 'color': Colors.yellow[100]!},
    ];

    return productCategory(context, 'Dairy, Bread & Egg', items);
  }

  static Widget vegetablesFruits(BuildContext context) {
    final items = [
      {'name': 'Citrus Fruits', 'color': Colors.orange[300]!},
      {'name': 'Berries', 'color': Colors.purple[300]!},
      {'name': 'Melons', 'color': Colors.red[300]!},
      {'name': 'Tropical Fruits', 'color': Colors.orange[400]!},
      {'name': 'Leafy Vegetables', 'color': Colors.green[400]!},
      {'name': 'Root Vegetables', 'color': Colors.pink[200]!},
      {'name': 'Gourds & Squash', 'color': Colors.green[300]!},
    ];

    return productCategory(context, 'Vegetables & Fruits', items);
  }
}
