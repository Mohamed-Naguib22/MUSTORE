import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/profile/domain/entities/contact.dart';
import 'package:mustore/features/profile/domain/repositories/contact_repository.dart';

class GetContactsUseCase implements UseCase<List<Contact>, NoParams> {
  const GetContactsUseCase(this._repository);

  final ContactRepository _repository;

  @override
  Future<Either<Failure, List<Contact>>> call(NoParams params) async =>
      await _repository.getContacts();
}