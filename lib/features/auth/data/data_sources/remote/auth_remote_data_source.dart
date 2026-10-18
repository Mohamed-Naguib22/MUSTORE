import 'package:dartz/dartz.dart';
import 'package:mustore/features/auth/data/models/auth_session_model.dart';
import 'package:mustore/features/auth/domain/params/change_password_params.dart';
import 'package:mustore/features/auth/domain/params/external_login_params.dart';
import 'package:mustore/features/auth/domain/params/forget_password_params.dart';
import 'package:mustore/features/auth/domain/params/login_params.dart';
import 'package:mustore/features/auth/domain/params/refresh_token_params.dart';
import 'package:mustore/features/auth/domain/params/register_params.dart';
import 'package:mustore/features/auth/domain/params/resend_otp_params.dart';
import 'package:mustore/features/auth/domain/params/reset_password_params.dart';
import 'package:mustore/features/auth/domain/params/revoke_session_params.dart';
import 'package:mustore/features/auth/domain/params/verify_email_params.dart';

abstract interface class AuthRemoteDataSource {
  Future<AuthSessionModel> login(LoginParams params);
  Future<Unit> register(RegisterParams params);
  Future<AuthSessionModel> verifyEmail(VerifyEmailParams params);
  Future<Unit> resendOtp(ResendOtpParams params);
  Future<AuthSessionModel> externalLogin(ExternalLoginParams params);
  Future<AuthSessionModel> refreshToken(RefreshTokenParams params);
  Future<Unit> revokeSession(RevokeSessionParams params);
  Future<Unit> forgetPassword(ForgetPasswordParams params);
  Future<AuthSessionModel> resetPassword(ResetPasswordParams params);
  Future<AuthSessionModel> changePassword(ChangePasswordParams params);
}