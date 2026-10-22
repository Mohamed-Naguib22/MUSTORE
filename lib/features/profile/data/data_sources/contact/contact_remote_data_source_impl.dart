import 'package:mustore/core/network/api/api_client.dart';
import 'package:mustore/features/profile/data/constants/contact_endpoints.dart';
import 'package:mustore/features/profile/data/models/contact_model.dart';
import 'package:mustore/features/profile/domain/params/contact/update_contact_params.dart';
import 'package:mustore/features/profile/domain/params/contact/verify_contact_params.dart';
import 'contact_remote_data_source.dart';

class ContactRemoteDataSourceImpl implements ContactRemoteDataSource {
  const ContactRemoteDataSourceImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<List<ContactModel>> getContacts() async {
    final response = await _apiClient.get(path: ContactEndpoints.getAll);

    return (response.data as List)
        .map((e) => ContactModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ContactModel> addContact(String phoneNumber) async {
    final response = await _apiClient.post(
      path: ContactEndpoints.add,
      data: {
        'phoneNumber': phoneNumber
      },
    );

    return ContactModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> updateContact(UpdateContactParams params) async {
    await _apiClient.put(
      path: ContactEndpoints.update(params.contactId),
      data: params.toJson(),
    );
  }

  @override
  Future<void> deleteContact(String contactId) async {
    await _apiClient.delete(path: ContactEndpoints.delete(contactId));
  }

  @override
  Future<void> sendVerificationCode(String contactId) async {
    await _apiClient.post(
      path: ContactEndpoints.sendCode,
      data: {
        'contactId': contactId
      },
    );
  }

  @override
  Future<void> verifyContact(VerifyContactParams params) async {
    await _apiClient.post(
      path: ContactEndpoints.verify,
      data: params.toJson(),
    );
  }

  @override
  Future<void> setAsPrimary(String contactId) async {
    await _apiClient.patch(
      path: ContactEndpoints.setAsPrimary(contactId),
      data: {
        'contactId': contactId
      },
    );
  }
}