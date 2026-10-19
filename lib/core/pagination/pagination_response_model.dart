import 'paginated_list.dart';

class PaginationResponseModel<T> extends PaginatedList<T> {
  const PaginationResponseModel({
    required super.items,
    required super.totalCount,
    required super.currentPage,
    required super.pageSize,
    required super.totalPages,
  });

  factory PaginationResponseModel.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT,
      ) {
    return PaginationResponseModel<T>(
      items: (json['results'] as List<dynamic>? ?? [])
          .map((e) => fromJsonT(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int? ?? 0,
      currentPage: (json['currentPage'] ?? json['pageNumber']) as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? 0,
      totalPages: json['numberOfPages'] as int? ?? 0,
    );
  }
}