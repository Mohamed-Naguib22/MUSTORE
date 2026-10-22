import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/settings/domain/repositories/settings_repository.dart';

class SetLocaleUseCase implements UseCase<Unit, Locale?> {
  const SetLocaleUseCase(this._repository);
  final SettingsRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(Locale? params) async =>
      await _repository.setLocale(params);
}