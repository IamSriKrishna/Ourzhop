// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceRangeModel _$PriceRangeModelFromJson(Map<String, dynamic> json) =>
    PriceRangeModel(
      minPrice: (json['min_price'] as num).toDouble(),
      maxPrice: (json['max_price'] as num).toDouble(),
    );

Map<String, dynamic> _$PriceRangeModelToJson(PriceRangeModel instance) =>
    <String, dynamic>{
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
    };

ProductVariantModel _$ProductVariantModelFromJson(Map<String, dynamic> json) =>
    ProductVariantModel(
      productVariantId: json['product_variant_id'] as String,
      productId: json['product_id'] as String,
      shopId: json['shop_id'] as String,
      sku: json['sku'] as String,
      barcode: json['barcode'] as String,
      variantName: json['variant_name'] as String,
      unitValue: (json['unit_value'] as num).toInt(),
      mrp: (json['mrp'] as num).toDouble(),
      sellingPrice: (json['selling_price'] as num).toDouble(),
      discountPercentage: (json['discount_percentage'] as num).toInt(),
      currentStock: (json['current_stock'] as num).toInt(),
      inStock: json['in_stock'] as bool,
      minOrderQuantity: (json['min_order_quantity'] as num).toInt(),
      maxOrderQuantity: (json['max_order_quantity'] as num).toInt(),
      weightGrams: (json['weight_grams'] as num).toInt(),
      dimensions: json['dimensions'] as String?,
      isActive: json['is_active'] as bool,
      sortOrder: (json['sort_order'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ProductVariantModelToJson(
        ProductVariantModel instance) =>
    <String, dynamic>{
      'product_variant_id': instance.productVariantId,
      'product_id': instance.productId,
      'shop_id': instance.shopId,
      'sku': instance.sku,
      'barcode': instance.barcode,
      'variant_name': instance.variantName,
      'unit_value': instance.unitValue,
      'mrp': instance.mrp,
      'selling_price': instance.sellingPrice,
      'discount_percentage': instance.discountPercentage,
      'current_stock': instance.currentStock,
      'in_stock': instance.inStock,
      'min_order_quantity': instance.minOrderQuantity,
      'max_order_quantity': instance.maxOrderQuantity,
      'weight_grams': instance.weightGrams,
      'dimensions': instance.dimensions,
      'is_active': instance.isActive,
      'sort_order': instance.sortOrder,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      productId: json['product_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      brand: json['brand'] as String,
      unitName: json['unit_name'] as String,
      primaryImage: json['primary_image'] as String,
      rating: (json['rating'] as num).toInt(),
      reviewCount: (json['review_count'] as num).toInt(),
      dietaryType: json['dietary_type'] as String,
      priceRange:
          PriceRangeModel.fromJson(json['price_range'] as Map<String, dynamic>),
      hasVariants: json['has_variants'] as bool,
      variantCount: (json['variant_count'] as num).toInt(),
      hasStock: json['has_stock'] as bool,
      variants: (json['variants'] as List<dynamic>)
          .map((e) => ProductVariantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'name': instance.name,
      'description': instance.description,
      'brand': instance.brand,
      'unit_name': instance.unitName,
      'primary_image': instance.primaryImage,
      'rating': instance.rating,
      'review_count': instance.reviewCount,
      'dietary_type': instance.dietaryType,
      'has_variants': instance.hasVariants,
      'variant_count': instance.variantCount,
      'has_stock': instance.hasStock,
      'price_range': instance.priceRange,
      'variants': instance.variants,
    };

ProductsResponseModel _$ProductsResponseModelFromJson(
        Map<String, dynamic> json) =>
    ProductsResponseModel(
      status: json['status'] as String,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: ApiMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductsResponseModelToJson(
        ProductsResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'meta': instance.meta,
    };
