import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/pagination/paginated_list.dart';
import 'package:mustore/core/pagination/pagination_params.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/catalog/domain/entities/product/product.dart';
import 'package:mustore/features/catalog/domain/repositories/product_repository.dart';

class GetProductsOnSaleUseCase
    implements UseCase<PaginatedList<Product>, PaginationParams> {
  const GetProductsOnSaleUseCase(this._repository);
  final ProductRepository _repository;

  @override
  Future<Either<Failure, PaginatedList<Product>>> call(
      PaginationParams params,
      ) async =>
      await _repository.getProductsOnSale(params);
}