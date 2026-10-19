import 'package:equatable/equatable.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/pagination/paginated_list.dart';

enum PaginationStatus { initial, loading, loadingMore, success, failure }

class PaginationState<T> extends Equatable {
  final PaginationStatus status;
  final PaginatedList<T> data;
  final Failure? failure;

  PaginationState({
    this.status = PaginationStatus.initial,
    PaginatedList<T>? data,
    this.failure,
  }) : data = data ?? PaginatedList<T>.empty();

  bool get isBusy =>
      status == PaginationStatus.loading ||
          status == PaginationStatus.loadingMore;

  PaginationState<T> copyWith({
    PaginationStatus? status,
    PaginatedList<T>? data,
    Failure? failure,
  }) =>
      PaginationState<T>(
        status: status ?? this.status,
        data: data ?? this.data,
        failure: failure,
      );

  @override
  List<Object?> get props => [status, data, failure];
}