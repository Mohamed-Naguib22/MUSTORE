import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/settings/domain/repositories/settings_repository.dart';

class GetLocaleUseCase implements UseCase<Locale?, NoParams> {
  const GetLocaleUseCase(this._repository);
  final SettingsRepository _repository;

  @override
  Future<Either<Failure, Locale?>> call(NoParams params) =>
      _repository.getLocale();
}