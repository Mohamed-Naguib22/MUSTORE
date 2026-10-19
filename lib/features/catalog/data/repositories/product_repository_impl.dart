import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/network/connectivity/network_connection.dart';
import 'package:mustore/core/pagination/pagination_params.dart';
import 'package:mustore/core/pagination/paginated_list.dart';
import 'package:mustore/core/utils/mixins/network_mixin.dart';
import 'package:mustore/features/catalog/data/data_sources/remote/product_remote_data_source.dart';
import 'package:mustore/features/catalog/domain/entities/product/product.dart';
import 'package:mustore/features/catalog/domain/repositories/product_repository.dart';

class ProductRepositoryImpl with NetworkMixin implements ProductRepository {
  const ProductRepositoryImpl({
    required this.networkConnection,
    required ProductRemoteDataSource remoteDataSource,
  })  : _remote = remoteDataSource;

  @override
  final NetworkConnection networkConnection;

  final ProductRemoteDataSource _remote;

  @override
  Future<Either<Failure, PaginatedList<Product>>> getRecentlyViewedProducts(
      PaginationParams params) =>
      onlineOnly<PaginatedList<Product>>(
              () => _remote.getRecentlyViewedProducts(params));

  @override
  Future<Either<Failure, PaginatedList<Product>>> getPreviouslyOrdered(
      PaginationParams params) =>
      onlineOnly<PaginatedList<Product>>(
              () => _remote.getPreviouslyOrdered(params));

  @override
  Future<Either<Failure, PaginatedList<Product>>> getNewArrivals(
      PaginationParams params) =>
      onlineOnly<PaginatedList<Product>>(
              () => _remote.getNewArrivals(params));

  @override
  Future<Either<Failure, PaginatedList<Product>>> getRecommendedProducts(
      PaginationParams params) =>
      onlineOnly<PaginatedList<Product>>(
              () => _remote.getRecommendedProducts(params));

  @override
  Future<Either<Failure, PaginatedList<Product>>> getProductsOnSale(
      PaginationParams params) =>
      onlineOnly<PaginatedList<Product>>(
              () => _remote.getProductsOnSale(params));
}