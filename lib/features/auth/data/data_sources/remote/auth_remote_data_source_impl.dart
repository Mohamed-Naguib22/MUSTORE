import 'package:dartz/dartz.dart';
import 'package:mustore/core/network/api/api_client.dart';
import 'package:mustore/features/auth/data/constants/auth_endpoints.dart';
import 'package:mustore/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
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

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<AuthSessionModel> login(LoginParams params) async {
    final response = await _apiClient.post(
      path: AuthEndpoints.login,
      data: params.toJson(),
    );

    return AuthSessionModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<Unit> register(RegisterParams params) async {
    await _apiClient.post(
      path: AuthEndpoints.register,
      data: params.toJson(),
      multipart: true,
    );

    return unit;
  }

  @override
  Future<AuthSessionModel> verifyEmail(VerifyEmailParams params) async {
    final response = await _apiClient.post(
      path: AuthEndpoints.verifyEmail,
      data: params.toJson(),
    );

    return AuthSessionModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<Unit> resendOtp(ResendOtpParams params) async {
    await _apiClient.post(
      path: AuthEndpoints.resendOtp,
      data: params.toJson(),
    );

    return unit;
  }

  @override
  Future<AuthSessionModel> externalLogin(ExternalLoginParams params) async {
    final response = await _apiClient.post(
      path: AuthEndpoints.externalLogin,
      data: params.toJson(),
    );

    return AuthSessionModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<AuthSessionModel> refreshToken(RefreshTokenParams params) async {
    final response = await _apiClient.post(
      path: AuthEndpoints.refreshToken,
      data: params.toJson(),
    );

    return AuthSessionModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<Unit> revokeSession(RevokeSessionParams params) async {
    await _apiClient.post(
      path: AuthEndpoints.revokeSession,
      data: params.toJson(),
    );

    return unit;
  }

  @override
  Future<Unit> forgetPassword(ForgetPasswordParams params) async {
    await _apiClient.post(
      path: AuthEndpoints.forgetPassword,
      data: params.toJson(),
    );

    return unit;
  }

  @override
  Future<AuthSessionModel> resetPassword(ResetPasswordParams params) async {
    final response = await _apiClient.put(
      path: AuthEndpoints.resetPassword,
      data: params.toJson(),
    );

    return AuthSessionModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<AuthSessionModel> changePassword(ChangePasswordParams params) async {
    final response = await _apiClient.put(
      path: AuthEndpoints.changePassword,
      data: params.toJson(),
    );

    return AuthSessionModel.fromJson(response.data as Map<String, dynamic>);
  }
}