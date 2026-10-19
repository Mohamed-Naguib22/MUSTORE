abstract final class AuthEndpoints {
  static const String _prefix = 'Auth';

  static const login = '$_prefix/Login';
  static const register = '$_prefix/Register';
  static const refreshToken = '$_prefix/RefreshToken';
  static const revokeSession = '$_prefix/RevokeSession';
  static const resetPassword = '$_prefix/ResetPassword';
  static const changePassword = '$_prefix/ChangePassword';
  static const forgetPassword = '$_prefix/ForgetPassword';
  static const verifyEmail = '$_prefix/VerifyEmail';
  static const resendOtp = '$_prefix/ResendOtp';
  static const externalLogin = '$_prefix/ExternalLogin';
}