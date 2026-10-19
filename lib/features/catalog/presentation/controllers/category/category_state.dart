import 'package:equatable/equatable.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/features/catalog/domain/entities/category/category.dart';

class CategoryState extends Equatable {
  const CategoryState({
    this.status = RequestStatus.initial,
    this.rootCategories = const [],
    this.failure,
  });

  final RequestStatus status;
  final List<Category> rootCategories;
  final Failure? failure;

  CategoryState copyWith({
    RequestStatus? status,
    List<Category>? rootCategories,
    Failure? failure,
    bool clearFailure = false,
  }) =>
      CategoryState(
        status: status ?? this.status,
        rootCategories: rootCategories ?? this.rootCategories,
        failure: clearFailure ? null : (failure ?? this.failure),
      );

  @override
  List<Object?> get props => [status, rootCategories, failure];
}