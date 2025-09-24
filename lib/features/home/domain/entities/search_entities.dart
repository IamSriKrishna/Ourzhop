import 'package:customer_app/common/network/models/api_envelope.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class SearchResultEntity {
  final String id;
  final String type;
  final String name;
  final String description;
  final double similarityScore;
  final double distanceKm;

  const SearchResultEntity({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.similarityScore,
    required this.distanceKm,
  });
}

@immutable
class SearchAutocompleteResponseEntity {
  final String status;
  final String message;
  final List<SearchResultEntity> data;
  final ApiMeta meta;

  const SearchAutocompleteResponseEntity({
    required this.status,
    required this.message,
    required this.data,
    required this.meta,
  });
}
