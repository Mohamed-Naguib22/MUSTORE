import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/profile/domain/params/contact/verify_contact_params.dart';
import 'package:mustore/features/profile/domain/repositories/contact_repository.dart';

class VerifyContactUseCase implements UseCase<Unit, VerifyContactParams> {
  const VerifyContactUseCase(this._repository);

  final ContactRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(VerifyContactParams params) async =>
      await _repository.verifyContact(params);
}