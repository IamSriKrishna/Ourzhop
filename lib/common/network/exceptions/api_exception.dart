class ApiException implements Exception {
  final int? statusCode; // HTTP status – may be null (e.g., socket failure)
  final String message;
  final String? code; // optional, useful for analytics / retry rules

  const ApiException({
    this.statusCode,
    required this.message,
    this.code,
  });

  @override
  String toString() => 'ApiException($statusCode, $code): $message';
}
