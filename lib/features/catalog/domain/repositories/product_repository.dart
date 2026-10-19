import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/pagination/paginated_list.dart';
import 'package:mustore/core/pagination/pagination_params.dart';
import 'package:mustore/features/catalog/domain/entities/product/product.dart';

abstract interface class ProductRepository {
  Future<Either<Failure, PaginatedList<Product>>> getRecentlyViewedProducts(PaginationParams params,);
  Future<Either<Failure, PaginatedList<Product>>> getPreviouslyOrdered(PaginationParams params,);
  Future<Either<Failure, PaginatedList<Product>>> getNewArrivals(PaginationParams params,);
  Future<Either<Failure, PaginatedList<Product>>> getRecommendedProducts(PaginationParams params,);
  Future<Either<Failure, PaginatedList<Product>>> getProductsOnSale(PaginationParams params,);
  Future<Either<Failure, PaginatedList<Product>>> bestSellerProducts(PaginationParams params,);
}