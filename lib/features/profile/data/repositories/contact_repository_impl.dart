import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/network/connectivity/network_connection.dart';
import 'package:mustore/core/utils/mixins/network_mixin.dart';
import 'package:mustore/features/profile/data/data_sources/contact/contact_remote_data_source.dart';
import 'package:mustore/features/profile/domain/entities/contact.dart';
import 'package:mustore/features/profile/domain/params/contact/update_contact_params.dart';
import 'package:mustore/features/profile/domain/params/contact/verify_contact_params.dart';
import 'package:mustore/features/profile/domain/repositories/contact_repository.dart';

class ContactRepositoryImpl with NetworkMixin implements ContactRepository {
  const ContactRepositoryImpl({
    required this.networkConnection,
    required ContactRemoteDataSource remoteDataSource,
  }) : _remote = remoteDataSource;

  @override
  final NetworkConnection networkConnection;

  final ContactRemoteDataSource _remote;

  @override
  Future<Either<Failure, List<Contact>>> getContacts() =>
      onlineOnly<List<Contact>>(() async => await _remote.getContacts());

  @override
  Future<Either<Failure, Contact>> addContact(String phoneNumber) =>
      onlineOnly<Contact>(() async => await _remote.addContact(phoneNumber));

  @override
  Future<Either<Failure, Unit>> updateContact(UpdateContactParams params) =>
      onlineOnly<Unit>(() async {
        await _remote.updateContact(params);
        return unit;
      });

  @override
  Future<Either<Failure, Unit>> deleteContact(String contactId) =>
      onlineOnly<Unit>(() async {
        await _remote.deleteContact(contactId);
        return unit;
      });

  @override
  Future<Either<Failure, Unit>> setAsPrimary(String contactId) =>
      onlineOnly<Unit>(() async {
        await _remote.setAsPrimary(contactId);
        return unit;
      });

  @override
  Future<Either<Failure, Unit>> sendVerificationCode(String contactId) =>
      onlineOnly<Unit>(() async {
        await _remote.sendVerificationCode(contactId);
        return unit;
      });

  @override
  Future<Either<Failure, Unit>> verifyContact(VerifyContactParams params) =>
      onlineOnly<Unit>(() async {
        await _remote.verifyContact(params);
        return unit;
      });
}