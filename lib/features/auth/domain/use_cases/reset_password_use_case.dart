import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/auth/domain/entities/auth_session.dart';
import 'package:mustore/features/auth/domain/params/reset_password_params.dart';
import 'package:mustore/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase
    implements UseCase<AuthSession, ResetPasswordParams> {
  const ResetPasswordUseCase(this._repository);
  final AuthRepository _repository;

  @override
  Future<Either<Failure, AuthSession>> call(ResetPasswordParams params) =>
      _repository.resetPassword(params);
}