import 'package:get_it/get_it.dart';
import 'package:mustore/core/network/api/api_client.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/lookup/domain/use_cases/get_lookups_use_case.dart';
import 'package:mustore/features/profile/data/data_sources/address/location_remote_data_source.dart';
import 'package:mustore/features/profile/data/data_sources/address/location_remote_data_source_impl.dart';
import 'package:mustore/features/profile/data/repositories/location_repository.dart';
import 'package:mustore/features/profile/domain/repositories/location_repository.dart';
import 'package:mustore/features/profile/presentation/controllers/location/location_cubit.dart';

abstract final class LookupInstanceNames {
  static const String countries = 'lookup_countries';
  static const String governorates = 'lookup_governorates';
  static const String cities = 'lookup_cities';
}

void registerLookupModule(GetIt sl) {
  sl.registerLazySingleton<LocationRemoteDataSource>(
        () => LocationRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );

  sl.registerLazySingleton<LocationRepository>(
        () => LocationRepositoryImpl(
      networkConnection: sl(),
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<GetLookupsUseCase<NoParams>>(
        () => GetLookupsUseCase((_) => sl<LocationRepository>().getCountries()),
    instanceName: LookupInstanceNames.countries,
  );

  sl.registerLazySingleton<GetLookupsUseCase<String>>(
        () => GetLookupsUseCase(sl<LocationRepository>().getGovernoratesByCountryId),
    instanceName: LookupInstanceNames.governorates,
  );

  sl.registerLazySingleton<GetLookupsUseCase<String>>(
        () => GetLookupsUseCase(sl<LocationRepository>().getCitiesByGovernorateId),
    instanceName: LookupInstanceNames.cities,
  );

  sl.registerFactory(
        () => LocationCubit(
      getCountries: sl(instanceName: LookupInstanceNames.countries),
      getGovernorates: sl(instanceName: LookupInstanceNames.governorates),
      getCities: sl(instanceName: LookupInstanceNames.cities),
    ),
  );
}