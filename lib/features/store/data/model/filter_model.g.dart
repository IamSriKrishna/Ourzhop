// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryFilterModel _$CategoryFilterModelFromJson(Map<String, dynamic> json) =>
    CategoryFilterModel(
      id: json['id'] as String,
      name: json['name'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$CategoryFilterModelToJson(
        CategoryFilterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'count': instance.count,
    };

BrandFilterModel _$BrandFilterModelFromJson(Map<String, dynamic> json) =>
    BrandFilterModel(
      id: json['id'] as String,
      name: json['name'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$BrandFilterModelToJson(BrandFilterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'count': instance.count,
    };

PriceRangeFilterModel _$PriceRangeFilterModelFromJson(
        Map<String, dynamic> json) =>
    PriceRangeFilterModel(
      minPrice: (json['min_price'] as num).toDouble(),
      maxPrice: (json['max_price'] as num).toDouble(),
    );

Map<String, dynamic> _$PriceRangeFilterModelToJson(
        PriceRangeFilterModel instance) =>
    <String, dynamic>{
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
    };

DietaryTypeFilterModel _$DietaryTypeFilterModelFromJson(
        Map<String, dynamic> json) =>
    DietaryTypeFilterModel(
      id: json['id'] as String,
      name: json['name'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$DietaryTypeFilterModelToJson(
        DietaryTypeFilterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'count': instance.count,
    };

ShopFiltersDataModel _$ShopFiltersDataModelFromJson(
        Map<String, dynamic> json) =>
    ShopFiltersDataModel(
      categories: (json['categories'] as List<dynamic>)
          .map((e) => CategoryFilterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      brands: (json['brands'] as List<dynamic>)
          .map((e) => BrandFilterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      priceRange: PriceRangeFilterModel.fromJson(
          json['price_range'] as Map<String, dynamic>),
      dietaryTypes: (json['dietary_types'] as List<dynamic>)
          .map(
              (e) => DietaryTypeFilterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasDiscounts: json['has_discounts'] as bool,
      totalProducts: (json['total_products'] as num).toInt(),
    );

Map<String, dynamic> _$ShopFiltersDataModelToJson(
        ShopFiltersDataModel instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'brands': instance.brands,
      'price_range': instance.priceRange,
      'dietary_types': instance.dietaryTypes,
      'has_discounts': instance.hasDiscounts,
      'total_products': instance.totalProducts,
    };

ShopFiltersResponseModel _$ShopFiltersResponseModelFromJson(
        Map<String, dynamic> json) =>
    ShopFiltersResponseModel(
      status: json['status'] as String,
      message: json['message'] as String,
      data: ShopFiltersDataModel.fromJson(json['data'] as Map<String, dynamic>),
      meta: ApiMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShopFiltersResponseModelToJson(
        ShopFiltersResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'meta': instance.meta,
    };
