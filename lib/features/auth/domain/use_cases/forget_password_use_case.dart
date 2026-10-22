import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/auth/domain/params/forget_password_params.dart';
import 'package:mustore/features/auth/domain/repositories/auth_repository.dart';

class ForgetPasswordUseCase implements UseCase<Unit, ForgetPasswordParams> {
  const ForgetPasswordUseCase(this._repository);
  final AuthRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(ForgetPasswordParams params) async =>
      await _repository.forgetPassword(params);
}