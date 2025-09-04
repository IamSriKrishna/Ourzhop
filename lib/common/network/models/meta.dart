/// Holds the server-supplied `meta` section for **all** endpoints.
///
/// * `requestId`   – same as `request_id` in envelope (nullable)
/// * `timestamp`   – ISO-8601 string from backend (nullable)
/// * `hasMore`     – only set on paged endpoints
/// * `nextCursor`  – present when `hasMore == true`
class MetaInfo {
  final String? requestId;
  final String? timestamp;
  final bool? hasMore;
  final String? nextCursor;

  const MetaInfo({
    this.requestId,
    this.timestamp,
    this.hasMore,
    this.nextCursor,
  });

  /// `true` only when backend signalled there are more pages.
  bool get hasNextPage => hasMore ?? false;

  /// Quick flag for “is this a paginated response?”
  bool get isPaginated => hasMore != null;
}

class DataWithMeta<T> {
  final T data;
  final MetaInfo meta;

  const DataWithMeta({
    required this.data,
    required this.meta,
  });

  bool get hasNextPage => meta.hasNextPage;
  String? get nextCursor => meta.nextCursor;
}
