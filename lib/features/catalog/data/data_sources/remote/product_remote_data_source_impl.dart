import 'package:mustore/core/network/api/api_client.dart';
import 'package:mustore/core/pagination/pagination_params.dart';
import 'package:mustore/core/pagination/pagination_response_model.dart';
import 'package:mustore/features/catalog/data/constants/product_endpoints.dart';
import 'package:mustore/features/catalog/data/data_sources/remote/product_remote_data_source.dart';
import 'package:mustore/features/catalog/data/models/product_model.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  const ProductRemoteDataSourceImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<PaginationResponseModel<ProductModel>> getRecentlyViewedProducts(
      PaginationParams params) =>
      _getProducts(ProductEndpoints.recentlyViewedProducts, params);

  @override
  Future<PaginationResponseModel<ProductModel>> getPreviouslyOrdered(
      PaginationParams params) =>
      _getProducts(ProductEndpoints.previouslyOrdered, params);

  @override
  Future<PaginationResponseModel<ProductModel>> getNewArrivals(
      PaginationParams params) =>
      _getProducts(ProductEndpoints.newArrivals, params);

  @override
  Future<PaginationResponseModel<ProductModel>> getRecommendedProducts(
      PaginationParams params) =>
      _getProducts(ProductEndpoints.recommendedProducts, params);

  @override
  Future<PaginationResponseModel<ProductModel>> getProductsOnSale(
      PaginationParams params) =>
      _getProducts(ProductEndpoints.productsOnSale, params);

  Future<PaginationResponseModel<ProductModel>> _getProducts(
      String endpoint,
      PaginationParams params,
      ) async {
    final response = await _apiClient.get(
      path: endpoint,
      query: params.toQueryParameters(),
    );
    return PaginationResponseModel.fromJson(
      response.data as Map<String, dynamic>,
      ProductModel.fromJson,
    );
  }
}