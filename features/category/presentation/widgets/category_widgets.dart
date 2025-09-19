// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';

/// Original category widgets with exact STACK LAYOUT design
class CategoryWidgets {
  const CategoryWidgets._();

  /// Creates Figma-exact category card with column layout
  static Widget enhancedCategoryCard({
    required BuildContext context,
    required String name,
    required String description,
    required String iconUrl,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14.0), // Figma: padding: 14px
        decoration: BoxDecoration(
          color: Colors.white, // Figma: Light color
          borderRadius:
              BorderRadius.circular(10.0), // Figma: borderRadius: 10px
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Image positioned at top-right
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 40.0, // Figma: dimensions width: 40
                height: 40.0, // Figma: dimensions height: 40
                child: CategoryIcon(
                  iconUrl: iconUrl,
                  categoryName: name,
                  color: Colors.transparent,
                  size: 40,
                ),
              ),
            ),

            const SizedBox(height: 10.0), // Gap between image and text

            // Text content aligned to start
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Category name - Figma styling
                  SizedBox(
                    width: 138.0, // Figma: dimensions width: 138
                    height: 24.0, // Figma: dimensions height: 24
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontFamily: 'Poppins', // Figma: fontFamily: Poppins
                        fontWeight: FontWeight.w500, // Figma: fontWeight: 500
                        fontSize: 16.0, // Figma: fontSize: 16
                        height: 1.5, // Figma: lineHeight: 1.5em
                        color: Color(0xFF17181A), // Figma: Dark color
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const SizedBox(height: 3.0), // Figma: gap: 3px

                  // Description - Figma styling
                  Text(
                    description,
                    style: const TextStyle(
                      fontFamily: 'Poppins', // Figma: fontFamily: Poppins
                      fontWeight: FontWeight.w400, // Figma: fontWeight: 400
                      fontSize: 14.0, // Figma: fontSize: 14
                      height: 1.5, // Figma: lineHeight: 1.5em
                      color: Color(0xFF61656A), // Figma: Gray Text color
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Creates the EXACT original categories grid layout
  static Widget categoriesGrid({
    required BuildContext context,
    required List<dynamic> categories,
    required Function(dynamic) onCategoryTap,
  }) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.4, // EXACT original ratio
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return enhancedCategoryCard(
          context: context,
          name: category.name,
          description: category.description,
          iconUrl: category.iconUrl,
          onTap: () => onCategoryTap(category),
        );
      },
    );
  }
}

/// Category icon widget with fallback emojis (EXACT from original)
class CategoryIcon extends StatelessWidget {
  const CategoryIcon({
    super.key,
    required this.iconUrl,
    required this.categoryName,
    required this.color,
    this.size = 24,
  });

  final String iconUrl;
  final String categoryName;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    // Try to load network image first from API
    if (iconUrl.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: CachedNetworkImage(
          imageUrl: iconUrl,
          width: size,
          height: size,
          fit: BoxFit.cover, // Figma: scaleMode: FILL, objectFit: cover
          placeholder: (context, url) => Container(
            width: size,
            height: size,
            color: Colors.grey[200],
            child: const Center(
              child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(strokeWidth: 2.0),
              ),
            ),
          ),
          errorWidget: (context, url, error) => _buildDefaultImage(),
        ),
      );
    }

    // Show default image when iconUrl is empty
    return _buildDefaultImage();
  }

  Widget _buildDefaultImage() {
    // Create a default image for empty iconUrl
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          _getDefaultIcon(categoryName),
          style: TextStyle(
            fontSize: size * 0.6,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }

  /// Get default emoji icon based on category name (EXACT from original)
  String _getDefaultIcon(String categoryName) {
    final name = categoryName.toLowerCase();

    // Food categories
    if (name.contains('pizza')) return '🍕';
    if (name.contains('burger')) return '🍔';
    if (name.contains('drink') || name.contains('beverage')) return '🥤';
    if (name.contains('coffee')) return '☕';
    if (name.contains('dessert') || name.contains('sweet')) return '🍰';
    if (name.contains('salad')) return '🥗';
    if (name.contains('chicken')) return '🍗';
    if (name.contains('seafood') || name.contains('fish')) return '🐟';
    if (name.contains('vegetarian') || name.contains('vegan')) return '🥬';
    if (name.contains('pasta')) return '🍝';
    if (name.contains('sandwich')) return '🥪';
    if (name.contains('soup')) return '🍲';
    if (name.contains('ice cream')) return '🍦';
    if (name.contains('bread') || name.contains('bakery')) return '🍞';
    if (name.contains('meat')) return '🥩';

    // General categories
    if (name.contains('fast')) return '⚡';
    if (name.contains('healthy')) return '💚';
    if (name.contains('spicy')) return '🌶️';
    if (name.contains('breakfast')) return '🌅';
    if (name.contains('lunch')) return '🌞';
    if (name.contains('dinner')) return '🌙';
    if (name.contains('snack')) return '🍿';

    // Default fallback
    return '🍽️';
  }
}
