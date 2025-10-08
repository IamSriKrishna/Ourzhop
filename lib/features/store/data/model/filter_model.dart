import 'package:customer_app/common/network/models/api_envelope.dart';
import 'package:customer_app/features/store/domain/entities/product_entities.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:json_annotation/json_annotation.dart';

part 'filter_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class CategoryFilterModel extends CategoryFilterEntity {
  const CategoryFilterModel({
    required super.id,
    required super.name,
    required super.count,
  });

  factory CategoryFilterModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryFilterModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryFilterModelToJson(this);
}

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class BrandFilterModel extends BrandFilterEntity {
  const BrandFilterModel({
    required super.id,
    required super.name,
    required super.count,
  });

  factory BrandFilterModel.fromJson(Map<String, dynamic> json) =>
      _$BrandFilterModelFromJson(json);

  Map<String, dynamic> toJson() => _$BrandFilterModelToJson(this);
}

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class PriceRangeFilterModel extends PriceRangeFilterEntity {
  const PriceRangeFilterModel({
    required super.minPrice,
    required super.maxPrice,
  });

  factory PriceRangeFilterModel.fromJson(Map<String, dynamic> json) =>
      _$PriceRangeFilterModelFromJson(json);

  Map<String, dynamic> toJson() => _$PriceRangeFilterModelToJson(this);
}

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class DietaryTypeFilterModel extends DietaryTypeFilterEntity {
  const DietaryTypeFilterModel({
    required super.id,
    required super.name,
    required super.count,
  });

  factory DietaryTypeFilterModel.fromJson(Map<String, dynamic> json) =>
      _$DietaryTypeFilterModelFromJson(json);

  Map<String, dynamic> toJson() => _$DietaryTypeFilterModelToJson(this);
}

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class ShopFiltersDataModel extends ShopFiltersDataEntity {
  @override
  final List<CategoryFilterModel> categories;

  @override
  final List<BrandFilterModel> brands;

  @override
  @JsonKey(name: 'price_range')
  final PriceRangeFilterModel priceRange;

  @override
  @JsonKey(name: 'dietary_types')
  final List<DietaryTypeFilterModel> dietaryTypes;

  @override
  final bool hasDiscounts;

  @override
  final int totalProducts;

  const ShopFiltersDataModel({
    required this.categories,
    required this.brands,
    required this.priceRange,
    required this.dietaryTypes,
    required this.hasDiscounts,
    required this.totalProducts,
  }) : super(
          categories: categories,
          brands: brands,
          priceRange: priceRange,
          dietaryTypes: dietaryTypes,
          hasDiscounts: hasDiscounts,
          totalProducts: totalProducts,
        );

  factory ShopFiltersDataModel.fromJson(Map<String, dynamic> json) =>
      _$ShopFiltersDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopFiltersDataModelToJson(this);
}

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class ShopFiltersResponseModel {
  final String status;
  final String message;
  final ShopFiltersDataModel data;
  final ApiMeta meta;

  const ShopFiltersResponseModel({
    required this.status,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory ShopFiltersResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ShopFiltersResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopFiltersResponseModelToJson(this);

  // Convert to entity
  ShopFiltersResponseEntity toEntity() => ShopFiltersResponseEntity(
        status: status,
        message: message,
        data: data,
        meta: meta,
      );
}