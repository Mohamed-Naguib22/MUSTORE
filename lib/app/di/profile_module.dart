import 'package:get_it/get_it.dart';
import 'package:mustore/core/network/api/api_client.dart';
import 'package:mustore/features/profile/data/data_sources/account/account_remote_data_source.dart';
import 'package:mustore/features/profile/data/data_sources/account/account_remote_data_source_impl.dart';
import 'package:mustore/features/profile/data/repositories/account_repository_impl.dart';
import 'package:mustore/features/profile/domain/repositories/account_repository.dart';
import 'package:mustore/features/profile/domain/use_cases/delete_account_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/delete_profile_picture_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/set_profile_picture_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:mustore/features/profile/presentation/controllers/profile_cubit.dart';

void registerProfileModule(GetIt sl) {
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