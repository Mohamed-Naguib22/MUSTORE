import 'package:mustore/features/profile/data/models/user_profile_model.dart';
import 'package:mustore/features/profile/domain/params/account/update_profile_params.dart';

abstract interface class AccountRemoteDataSource {
  Future<UserProfileModel> getProfile();
  Future<void> updateProfile(UpdateProfileParams params);
  Future<void> deleteAccount();
  Future<String> setProfilePicture(String filePath);
  Future<String> deleteProfilePicture();
}