import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/auth/domain/entities/auth_session.dart';
import 'package:mustore/features/auth/domain/params/refresh_token_params.dart';
import 'package:mustore/features/auth/domain/repositories/auth_repository.dart';

class RefreshTokenUseCase implements UseCase<AuthSession, RefreshTokenParams> {
  const RefreshTokenUseCase(this._repository);
  final AuthRepository _repository;

  @override
  Future<Either<Failure, AuthSession>> call(RefreshTokenParams params) async =>
      await _repository.refreshToken(params);
}