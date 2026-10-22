import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/profile/domain/params/contact/update_contact_params.dart';
import 'package:mustore/features/profile/domain/repositories/contact_repository.dart';

class UpdateContactUseCase implements UseCase<Unit, UpdateContactParams> {
  const UpdateContactUseCase(this._repository);

  final ContactRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(UpdateContactParams params) async =>
      await _repository.updateContact(params);
}