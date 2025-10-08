import 'package:customer_app/common/network/models/api_envelope.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class PriceRangeEntity {
  final double minPrice;
  final double maxPrice;

  const PriceRangeEntity({
    required this.minPrice,
    required this.maxPrice,
  });
}

@immutable
class ProductVariantEntity {
  final String productVariantId;
  final String productId;
  final String shopId;
  final String sku;
  final String barcode;
  final String variantName;
  final int unitValue;
  final double mrp;
  final double sellingPrice;
  final int discountPercentage;
  final int currentStock;
  final bool inStock;
  final int minOrderQuantity;
  final int maxOrderQuantity;
  final int weightGrams;
  final String? dimensions;
  final bool isActive;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProductVariantEntity({
    required this.productVariantId,
    required this.productId,
    required this.shopId,
    required this.sku,
    required this.barcode,
    required this.variantName,
    required this.unitValue,
    required this.mrp,
    required this.sellingPrice,
    required this.discountPercentage,
    required this.currentStock,
    required this.inStock,
    required this.minOrderQuantity,
    required this.maxOrderQuantity,
    required this.weightGrams,
    required this.dimensions,
    required this.isActive,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });
}

@immutable
class ProductEntity {
  final String productId;
  final String name;
  final String description;
  final String brand;
  final String unitName;
  final String primaryImage;
  final int rating;
  final int reviewCount;
  final String dietaryType;
  final PriceRangeEntity priceRange;
  final bool hasVariants;
  final int variantCount;
  final bool hasStock;
  final List<ProductVariantEntity> variants;

  const ProductEntity({
    required this.productId,
    required this.name,
    required this.description,
    required this.brand,
    required this.unitName,
    required this.primaryImage,
    required this.rating,
    required this.reviewCount,
    required this.dietaryType,
    required this.priceRange,
    required this.hasVariants,
    required this.variantCount,
    required this.hasStock,
    required this.variants,
  });
}

@immutable
class ProductsResponseEntity {
  final String status;
  final String message;
  final List<ProductEntity> data;
  final ApiMeta meta;

  const ProductsResponseEntity({
    required this.status,
    required this.message,
    required this.data,
    required this.meta,
  });
}

@immutable
class CategoryFilterEntity {
  final String id;
  final String name;
  final int count;

  const CategoryFilterEntity({
    required this.id,
    required this.name,
    required this.count,
  });
}

@immutable
class BrandFilterEntity {
  final String id;
  final String name;
  final int count;

  const BrandFilterEntity({
    required this.id,
    required this.name,
    required this.count,
  });
}

@immutable
class PriceRangeFilterEntity {
  final double minPrice;
  final double maxPrice;

  const PriceRangeFilterEntity({
    required this.minPrice,
    required this.maxPrice,
  });
}

@immutable
class DietaryTypeFilterEntity {
  final String id;
  final String name;
  final int count;

  const DietaryTypeFilterEntity({
    required this.id,
    required this.name,
    required this.count,
  });
}

@immutable
class ShopFiltersDataEntity {
  final List<CategoryFilterEntity> categories;
  final List<BrandFilterEntity> brands;
  final PriceRangeFilterEntity priceRange;
  final List<DietaryTypeFilterEntity> dietaryTypes;
  final bool hasDiscounts;
  final int totalProducts;

  const ShopFiltersDataEntity({
    required this.categories,
    required this.brands,
    required this.priceRange,
    required this.dietaryTypes,
    required this.hasDiscounts,
    required this.totalProducts,
  });
}

@immutable
class ShopFiltersResponseEntity {
  final String status;
  final String message;
  final ShopFiltersDataEntity data;
  final ApiMeta meta;

  const ShopFiltersResponseEntity({
    required this.status,
    required this.message,
    required this.data,
    required this.meta,
  });
}