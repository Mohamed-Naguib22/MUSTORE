abstract final class AccountEndpoints {
  static const String _prefix = 'User/Account';

  static const String getProfile = '$_prefix/GetProfile';
  static const String update = '$_prefix/updateProfile';
  static const String delete = '$_prefix/DeleteAccount';
  static const String setPicture = '$_prefix/SetProfilePicture';
  static const String deletePicture = '$_prefix/DeleteProfilePicture';
}