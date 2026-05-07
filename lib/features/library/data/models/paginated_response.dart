// lib/core/models/paginated_response.dart
class PaginatedResponse<T> {
  final List<T> data;
  final int currentPage;
  final int lastPage;
  final int total;
  final String? nextPageUrl;

  const PaginatedResponse({
    required this.data,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    this.nextPageUrl,
  });

  bool get hasMore => currentPage < lastPage;

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginatedResponse(
      data:        (json['data'] as List).map((e) => fromJsonT(e as Map<String, dynamic>)).toList(),
      currentPage: json['current_page'] as int,
      lastPage:    json['last_page'] as int,
      total:       json['total'] as int,
      nextPageUrl: json['next_page_url'] as String?,
    );
  }
}