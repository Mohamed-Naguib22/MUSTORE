import 'package:dio/dio.dart';
import 'package:mustore/core/network/api/api_client.dart';
import 'package:mustore/features/profile/data/constants/account_endpoints.dart';
import 'package:mustore/features/profile/data/models/user_profile_model.dart';
import 'package:mustore/features/profile/domain/params/update_profile_params.dart';
import 'account_remote_data_source.dart';

class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  const AccountRemoteDataSourceImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<UserProfileModel> getProfile() async {
    final response = await _apiClient.get(path: AccountEndpoints.getProfile);

    return UserProfileModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> updateProfile(UpdateProfileParams params) async {
    if (params.isEmpty) return;

    await _apiClient.put(
      path: AccountEndpoints.update,
      data: params.toJson(),
    );
  }

  @override
  Future<void> deleteAccount() =>
      _apiClient.delete(path: AccountEndpoints.delete);

  @override
  Future<void> setProfilePicture(String filePath) async {
    final file = await MultipartFile.fromFile(filePath);

    await _apiClient.post(
      path: AccountEndpoints.setPicture,
      data: {'profilePicture': file},
      multipart: true,
    );
  }

  @override
  Future<void> deleteProfilePicture() =>
      _apiClient.delete(path: AccountEndpoints.deletePicture);
}