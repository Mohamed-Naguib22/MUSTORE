import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/features/profile/domain/entities/contact.dart';
import 'package:mustore/features/profile/domain/params/contact/update_contact_params.dart';
import 'package:mustore/features/profile/domain/params/contact/verify_contact_params.dart';

abstract interface class ContactRepository {
  Future<Either<Failure, List<Contact>>> getContacts();
  Future<Either<Failure, Contact>> addContact(String phoneNumber);
  Future<Either<Failure, Unit>> updateContact(UpdateContactParams params);
  Future<Either<Failure, Unit>> deleteContact(String contactId);
  Future<Either<Failure, Unit>> setAsPrimary(String contactId);
  Future<Either<Failure, Unit>> sendVerificationCode(String contactId);
  Future<Either<Failure, Unit>> verifyContact(VerifyContactParams params);
}