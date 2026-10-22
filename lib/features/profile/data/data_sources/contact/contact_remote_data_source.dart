import 'package:mustore/features/profile/data/models/contact_model.dart';
import 'package:mustore/features/profile/domain/params/contact/update_contact_params.dart';
import 'package:mustore/features/profile/domain/params/contact/verify_contact_params.dart';

abstract interface class ContactRemoteDataSource {
  Future<List<ContactModel>> getContacts();
  Future<ContactModel> addContact(String phoneNumber);
  Future<void> updateContact(UpdateContactParams params);
  Future<void> deleteContact(String contactId);
  Future<void> sendVerificationCode(String phoneNumber);
  Future<void> verifyContact(VerifyContactParams params);
  Future<void> setAsPrimary(String contactId);
}