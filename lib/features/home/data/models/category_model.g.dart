// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      categoryId: json['category_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      slug: json['slug'] as String,
      iconUrl: json['icon_url'] as String,
      displayOrder: (json['display_order'] as num).toInt(),
      supportsDietary: json['supports_dietary'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'name': instance.name,
      'description': instance.description,
      'slug': instance.slug,
      'icon_url': instance.iconUrl,
      'display_order': instance.displayOrder,
      'supports_dietary': instance.supportsDietary,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

CategoriesResponseModel _$CategoriesResponseModelFromJson(
        Map<String, dynamic> json) =>
    CategoriesResponseModel(
      status: json['status'] as String,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoriesResponseModelToJson(
        CategoriesResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'meta': instance.meta,
    };

MetaModel _$MetaModelFromJson(Map<String, dynamic> json) => MetaModel(
      requestId: json['request_id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      hasMore: json['has_more'] as bool,
      nextCursor: json['next_cursor'] as String?,
    );

Map<String, dynamic> _$MetaModelToJson(MetaModel instance) => <String, dynamic>{
      'request_id': instance.requestId,
      'timestamp': instance.timestamp.toIso8601String(),
      'has_more': instance.hasMore,
      'next_cursor': instance.nextCursor,
    };
