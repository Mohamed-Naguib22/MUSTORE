class PaginationParams {
  const PaginationParams({
    this.pageNumber = 1,
    this.pageSize = 20,
  });

  final int pageNumber;
  final int pageSize;

  Map<String, dynamic> toQueryParameters() => {
    'pageNumber': pageNumber,
    'pageSize': pageSize,
  };
}