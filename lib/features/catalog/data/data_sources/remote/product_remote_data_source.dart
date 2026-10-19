import 'package:mustore/core/pagination/pagination_params.dart';
import 'package:mustore/core/pagination/pagination_response_model.dart';
import 'package:mustore/features/catalog/data/models/product_model.dart';

abstract interface class ProductRemoteDataSource {
  Future<PaginationResponseModel<ProductModel>> getRecentlyViewedProducts(PaginationParams params,);
  Future<PaginationResponseModel<ProductModel>> getPreviouslyOrdered(PaginationParams params,);
  Future<PaginationResponseModel<ProductModel>> getNewArrivals(PaginationParams params,);
  Future<PaginationResponseModel<ProductModel>> getRecommendedProducts(PaginationParams params,);
  Future<PaginationResponseModel<ProductModel>> getProductsOnSale(PaginationParams params,);
}