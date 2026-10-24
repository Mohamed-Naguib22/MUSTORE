import 'package:get_it/get_it.dart';
import 'package:mustore/core/network/api/api_client.dart';
import 'package:mustore/features/recommendation/data/data_sources/interests_remote_data_source.dart';
import 'package:mustore/features/recommendation/data/data_sources/interests_remote_data_source_impl.dart';
import 'package:mustore/features/recommendation/data/repositories/interests_repository_impl.dart';
import 'package:mustore/features/recommendation/domain/repositories/interests_repository.dart';
import 'package:mustore/features/recommendation/domain/use_cases/get_interests_use_case.dart';
import 'package:mustore/features/recommendation/domain/use_cases/set_interests_use_case.dart';
import 'package:mustore/features/recommendation/presentation/controllers/interests_cubit.dart';

void registerRecommendationModule(GetIt sl) {
  sl.registerLazySingleton<InterestsRemoteDataSource>(
        () => InterestsRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );

  sl.registerLazySingleton<InterestsRepository>(
        () => InterestsRepositoryImpl(
      networkConnection: sl(),
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetInterestsUseCase(sl()));
  sl.registerLazySingleton(() => SetInterestsUseCase(sl()));

  sl.registerFactory(
        () => InterestsCubit(
      getInterestTags: sl(),
      setInterestTags: sl(),
    ),
  );
}