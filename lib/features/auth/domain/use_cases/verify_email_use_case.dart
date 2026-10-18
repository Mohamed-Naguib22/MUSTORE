import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/auth/domain/entities/auth_session.dart';
import 'package:mustore/features/auth/domain/params/verify_email_params.dart';
import 'package:mustore/features/auth/domain/repositories/auth_repository.dart';

class VerifyEmailUseCase implements UseCase<AuthSession, VerifyEmailParams> {
  const VerifyEmailUseCase(this._repository);
  final AuthRepository _repository;

  @override
  Future<Either<Failure, AuthSession>> call(VerifyEmailParams params) =>
      _repository.verifyEmail(params);
}