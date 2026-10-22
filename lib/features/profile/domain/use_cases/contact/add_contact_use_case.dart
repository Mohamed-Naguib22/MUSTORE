import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/profile/domain/entities/contact.dart';
import 'package:mustore/features/profile/domain/repositories/contact_repository.dart';

class AddContactUseCase implements UseCase<Contact, String> {
  const AddContactUseCase(this._repository);

  final ContactRepository _repository;

  @override
  Future<Either<Failure, Contact>> call(String phoneNumber) =>
      _repository.addContact(phoneNumber);
}