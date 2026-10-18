import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mustore/core/error/failure.dart';

abstract interface class SettingsRepository {
  Future<Either<Failure, ThemeMode>> getThemeMode();
  Future<Either<Failure, Unit>> setThemeMode(ThemeMode mode);
  Future<Either<Failure, Locale?>> getLocale();
  Future<Either<Failure, Unit>> setLocale(Locale? locale);
}