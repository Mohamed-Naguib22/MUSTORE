import 'package:equatable/equatable.dart';

class PaginatedList<T> extends Equatable {
  final List<T> items;
  final int totalCount;
  final int currentPage;
  final int pageSize;
  final int totalPages;

  const PaginatedList({
    required this.items,
    required this.totalCount,
    required this.currentPage,
    required this.pageSize,
    required this.totalPages,
  });

  factory PaginatedList.empty({int pageSize = 10}) => PaginatedList<T>(
    items: <T>[],
    totalCount: 0,
    currentPage: 0,
    pageSize: pageSize,
    totalPages: 0,
  );

  bool get hasNextPage => currentPage < totalPages;
  bool get hasPreviousPage => currentPage > 1;
  bool get isEmpty => items.isEmpty;
  int get nextPage => currentPage + 1;

  PaginatedList<T> appendPage(PaginatedList<T> next) => PaginatedList<T>(
    items: [...items, ...next.items],
    totalCount: next.totalCount,
    currentPage: next.currentPage,
    pageSize: next.pageSize,
    totalPages: next.totalPages,
  );

  PaginatedList<R> map<R>(R Function(T) convert) => PaginatedList<R>(
    items: items.map(convert).toList(),
    totalCount: totalCount,
    currentPage: currentPage,
    pageSize: pageSize,
    totalPages: totalPages,
  );

  @override
  List<Object?> get props =>
      [items, totalCount, currentPage, pageSize, totalPages];
}