
import 'package:customer_app/common/network/models/api_envelope.dart';
import 'package:customer_app/features/store/domain/entities/product_entities.dart';
import 'package:flutter/foundation.dart' show immutable;

import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class PriceRangeModel extends PriceRangeEntity {
  const PriceRangeModel({
    required super.minPrice,
    required super.maxPrice,
  });

  factory PriceRangeModel.fromJson(Map<String, dynamic> json) =>
      _$PriceRangeModelFromJson(json);

  Map<String, dynamic> toJson() => _$PriceRangeModelToJson(this);
}

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class ProductVariantModel extends ProductVariantEntity {
  const ProductVariantModel({
    required super.productVariantId,
    required super.productId,
    required super.shopId,
    required super.sku,
    required super.barcode,
    required super.variantName,
    required super.unitValue,
    required super.mrp,
    required super.sellingPrice,
    required super.discountPercentage,
    required super.currentStock,
    required super.inStock,
    required super.minOrderQuantity,
    required super.maxOrderQuantity,
    required super.weightGrams,
    required super.dimensions,
    required super.isActive,
    required super.sortOrder,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ProductVariantModel.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductVariantModelToJson(this);
}

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class ProductModel extends ProductEntity {
  @override
  @JsonKey(name: 'price_range')
  final PriceRangeModel priceRange;

  @override
  final List<ProductVariantModel> variants;

  const ProductModel({
    required super.productId,
    required super.name,
    required super.description,
    required super.brand,
    required super.unitName,
    required super.primaryImage,
    required super.rating,
    required super.reviewCount,
    required super.dietaryType,
    required this.priceRange,
    required super.hasVariants,
    required super.variantCount,
    required super.hasStock,
    required this.variants,
  }) : super(priceRange: priceRange, variants: variants);

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class ProductsResponseModel {
  final String status;
  final String message;
  final List<ProductModel> data;
  final ApiMeta meta;

  const ProductsResponseModel({
    required this.status,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory ProductsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsResponseModelToJson(this);

  // Convert to entity
  ProductsResponseEntity toEntity() => ProductsResponseEntity(
        status: status,
        message: message,
        data: data,
        meta: meta,
      );
}