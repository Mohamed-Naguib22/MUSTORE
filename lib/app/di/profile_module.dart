import 'package:get_it/get_it.dart';
import 'package:mustore/core/network/api/api_client.dart';
import 'package:mustore/features/profile/data/data_sources/account/account_remote_data_source.dart';
import 'package:mustore/features/profile/data/data_sources/account/account_remote_data_source_impl.dart';
import 'package:mustore/features/profile/data/data_sources/address/address_remote_data_source.dart';
import 'package:mustore/features/profile/data/data_sources/address/address_remote_data_source_impl.dart';
import 'package:mustore/features/profile/data/repositories/account_repository_impl.dart';
import 'package:mustore/features/profile/data/repositories/address_repository_impl.dart';
import 'package:mustore/features/profile/domain/repositories/account_repository.dart';
import 'package:mustore/features/profile/domain/repositories/address_repository.dart';
import 'package:mustore/features/profile/domain/use_cases/account/delete_account_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/account/delete_profile_picture_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/account/get_profile_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/account/set_profile_picture_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/account/update_profile_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/address/add_address_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/address/delete_address_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/address/get_addresses_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/address/set_address_as_default_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/address/update_address_use_case.dart';
import 'package:mustore/features/profile/presentation/controllers/account/profile_cubit.dart';
import 'package:mustore/features/profile/presentation/controllers/address/address_cubit.dart';

void registerProfileModule(GetIt sl) {
  _registerAccountModule(sl);
  _registerAddressModule(sl);
}

void _registerAccountModule(GetIt sl) {
  sl.registerLazySingleton<AccountRemoteDataSource>(
        () => AccountRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );

  sl.registerLazySingleton<AccountRepository>(
        () => AccountRepositoryImpl(
      networkConnection: sl(),
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAccountUseCase(sl()));
  sl.registerLazySingleton(() => SetProfilePictureUseCase(sl()));
  sl.registerLazySingleton(() => DeleteProfilePictureUseCase(sl()));

  sl.registerFactory(
        () => ProfileCubit(
      getProfile: sl(),
      updateProfile: sl(),
      deleteAccount: sl(),
      setProfilePicture: sl(),
      deleteProfilePicture: sl(),
    ),
  );
}

void _registerAddressModule(GetIt sl) {
  sl.registerLazySingleton<AddressRemoteDataSource>(
        () => AddressRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );

  sl.registerLazySingleton<AddressRepository>(
        () => AddressRepositoryImpl(
      networkConnection: sl(),
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetAddressesUseCase(sl()));
  sl.registerLazySingleton(() => AddAddressUseCase(sl()));
  sl.registerLazySingleton(() => UpdateAddressUseCase(sl()));
  sl.registerLazySingleton(() => SetAddressAsDefaultUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAddressUseCase(sl()));

  sl.registerFactory(
        () => AddressCubit(
      getAddresses: sl(),
      addAddress: sl(),
      updateAddress: sl(),
      setAddressAsDefault: sl(),
      deleteAddress: sl(),
    ),
  );
}