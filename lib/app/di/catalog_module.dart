import 'package:get_it/get_it.dart';
import 'package:mustore/core/network/api/api_client.dart';
import 'package:mustore/features/catalog/data/data_sources/remote/product/product_remote_data_source.dart';
import 'package:mustore/features/catalog/data/data_sources/remote/product/product_remote_data_source_impl.dart';
import 'package:mustore/features/catalog/data/repositories/product_repository_impl.dart';
import 'package:mustore/features/catalog/domain/repositories/product_repository.dart';
import 'package:mustore/features/catalog/domain/use_cases/product/get_best_seller_products_use_case.dart';
import 'package:mustore/features/catalog/domain/use_cases/product/get_new_arrivals_use_case.dart';
import 'package:mustore/features/catalog/domain/use_cases/product/get_previously_ordered_use_case.dart';
import 'package:mustore/features/catalog/domain/use_cases/product/get_products_on_sale_use_case.dart';
import 'package:mustore/features/catalog/domain/use_cases/product/get_recently_viewed_products_use_case.dart';
import 'package:mustore/features/catalog/domain/use_cases/product/get_recommended_products_use_case.dart';
import 'package:mustore/features/catalog/presentation/controllers/product/product_cubit.dart';

void registerCatalogModule(GetIt sl) {
  sl.registerLazySingleton<ProductRemoteDataSource>(
        () => ProductRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );

  sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(
      networkConnection: sl(),
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetRecentlyViewedProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetPreviouslyOrderedUseCase(sl()));
  sl.registerLazySingleton(() => GetNewArrivalsUseCase(sl()));
  sl.registerLazySingleton(() => GetRecommendedProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetProductsOnSaleUseCase(sl()));
  sl.registerLazySingleton(() => GetBestSellerProductsUseCase(sl()));

  sl.registerFactory(() => ProductsCubit(
    getRecentlyViewed: sl(),
    getPreviouslyOrdered: sl(),
    getNewArrivals: sl(),
    getRecommended: sl(),
    getOnSale: sl(),
    getBestSeller: sl(),
  ));
}