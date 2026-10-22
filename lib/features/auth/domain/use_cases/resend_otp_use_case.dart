import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/auth/domain/params/resend_otp_params.dart';
import 'package:mustore/features/auth/domain/repositories/auth_repository.dart';

class ResendOtpUseCase implements UseCase<Unit, ResendOtpParams> {
  const ResendOtpUseCase(this._repository);
  final AuthRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(ResendOtpParams params) async =>
      await _repository.resendOtp(params);
}