import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/profile/domain/repositories/contact_repository.dart';

class DeleteContactUseCase implements UseCase<Unit, String> {
  const DeleteContactUseCase(this._repository);

  final ContactRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(String contactId) async =>
      await _repository.deleteContact(contactId);
}