import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/features/catalog/domain/entities/category/category.dart';

abstract interface class CategoryRepository {
  Future<Either<Failure, List<Category>>> rootCategories(int take);
}