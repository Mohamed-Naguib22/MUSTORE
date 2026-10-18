import 'package:get_it/get_it.dart';
import 'package:mustore/core/storage/local_storage.dart';
import 'package:mustore/features/settings/data/data_sources/settings_data_source.dart';
import 'package:mustore/features/settings/data/data_sources/settings_data_source_impl.dart';
import 'package:mustore/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:mustore/features/settings/domain/repositories/settings_repository.dart';
import 'package:mustore/features/settings/domain/use_cases/get_locale_use_case.dart';
import 'package:mustore/features/settings/domain/use_cases/get_theme_mode_use_case.dart';
import 'package:mustore/features/settings/domain/use_cases/set_locale_use_case.dart';
import 'package:mustore/features/settings/domain/use_cases/set_theme_mode_use_case.dart';
import 'package:mustore/features/settings/presentation/controllers/settings_cubit.dart';

void registerSettingsModule(GetIt sl) {
  sl.registerLazySingleton<SettingsLocalDataSource>(
        () => SettingsLocalDataSourceImpl(sl<LocalStorage>()),
  );

  sl.registerLazySingleton<SettingsRepository>(
        () => SettingsRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetThemeModeUseCase(sl()));
  sl.registerLazySingleton(() => SetThemeModeUseCase(sl()));
  sl.registerLazySingleton(() => GetLocaleUseCase(sl()));
  sl.registerLazySingleton(() => SetLocaleUseCase(sl()));

  sl.registerLazySingleton(
        () => SettingsCubit(
      getThemeMode: sl(),
      setThemeMode: sl(),
      getLocale: sl(),
      setLocale: sl(),
    ),
  );
}