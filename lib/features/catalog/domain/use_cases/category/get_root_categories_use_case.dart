import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/catalog/domain/repositories/category_repository.dart';
import 'package:mustore/features/catalog/domain/entities/category/category.dart';

class GetRootCategoriesUseCase
    implements UseCase<List<Category>, int> {
  const GetRootCategoriesUseCase(this._repository);
  final CategoryRepository _repository;

  @override
  Future<Either<Failure, List<Category>>> call(
      int take,
      ) =>
      _repository.rootCategories(take);
}