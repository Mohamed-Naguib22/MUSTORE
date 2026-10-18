import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/storage/cache_guard.dart';
import 'package:mustore/features/settings/data/data_sources/settings_data_source.dart';
import 'package:mustore/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._local);

  final SettingsLocalDataSource _local;

  @override
  Future<Either<Failure, ThemeMode>> getThemeMode() =>
      guardCache(_local.readTheme);

  @override
  Future<Either<Failure, Unit>> setThemeMode(ThemeMode mode) =>
      guardCache(() async {
        await _local.writeTheme(mode);
        return unit;
      });

  @override
  Future<Either<Failure, Locale?>> getLocale() => guardCache(_local.readLocale);

  @override
  Future<Either<Failure, Unit>> setLocale(Locale? locale) => guardCache(() async {
    await _local.writeLocale(locale);
    return unit;
  });
}