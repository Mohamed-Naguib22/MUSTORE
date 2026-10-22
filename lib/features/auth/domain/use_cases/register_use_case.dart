import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/auth/domain/params/register_params.dart';
import 'package:mustore/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase implements UseCase<Unit, RegisterParams> {
  const RegisterUseCase(this._repository);
  final AuthRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(RegisterParams params) async =>
      await _repository.register(params);
}