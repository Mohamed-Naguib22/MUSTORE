import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/auth/domain/params/revoke_session_params.dart';
import 'package:mustore/features/auth/domain/repositories/auth_repository.dart';

class RevokeSessionUseCase implements UseCase<Unit, RevokeSessionParams> {
  const RevokeSessionUseCase(this._repository);
  final AuthRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(RevokeSessionParams params) async =>
      await _repository.revokeSession(params);
}