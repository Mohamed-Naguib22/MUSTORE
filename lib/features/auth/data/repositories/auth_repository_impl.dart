import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/network/connectivity/network_connection.dart';
import 'package:mustore/core/utils/mixins/network_mixin.dart';
import 'package:mustore/features/auth/data/data_sources/local/token_storage.dart';
import 'package:mustore/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:mustore/features/auth/domain/entities/auth_session.dart';
import 'package:mustore/features/auth/domain/entities/auth_tokens.dart';
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
import 'package:mustore/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl with NetworkMixin implements AuthRepository {
  const AuthRepositoryImpl({
    required this.networkConnection,
    required AuthRemoteDataSource remoteDataSource,
    required TokenStorage tokenStorage,
  })  : _remote = remoteDataSource,
        _tokens = tokenStorage;

  @override
  final NetworkConnection networkConnection;

  final AuthRemoteDataSource _remote;
  final TokenStorage _tokens;

  Future<Either<Failure, AuthSession>> _persist(
      Future<Either<Failure, AuthSession>> call,
      ) async {
    final result = await call;
    await result.fold<Future<void>>(
          (_) async {},
          (s) => _tokens.save(AuthTokens(
        accessToken: s.accessToken,
        refreshToken: s.refreshToken,
        accessTokenExpirationDate: s.accessTokenExpirationDate,
        refreshTokenExpirationDate: s.refreshTokenExpirationDate,
      )),
    );
    return result;
  }

  @override
  Future<Either<Failure, AuthSession>> login(LoginParams params) =>
      _persist(onlineOnly<AuthSession>(() => _remote.login(params)));

  @override
  Future<Either<Failure, Unit>> register(RegisterParams params) =>
      onlineOnly<Unit>(() => _remote.register(params));

  @override
  Future<Either<Failure, AuthSession>> verifyEmail(VerifyEmailParams params) =>
      _persist(onlineOnly<AuthSession>(() => _remote.verifyEmail(params)));

  @override
  Future<Either<Failure, Unit>> resendOtp(ResendOtpParams params) =>
      onlineOnly<Unit>(() => _remote.resendOtp(params));

  @override
  Future<Either<Failure, AuthSession>> externalLogin(
      ExternalLoginParams params) =>
      _persist(onlineOnly<AuthSession>(() => _remote.externalLogin(params)));

  @override
  Future<Either<Failure, AuthSession>> refreshToken(
      RefreshTokenParams params) =>
      _persist(onlineOnly<AuthSession>(() => _remote.refreshToken(params)));

  @override
  Future<Either<Failure, Unit>> revokeSession(
      RevokeSessionParams params) async {
    final result =
    await onlineOnly<Unit>(() => _remote.revokeSession(params));
    await _tokens.clear();
    return result;
  }

  @override
  Future<Either<Failure, Unit>> forgetPassword(ForgetPasswordParams params) =>
      onlineOnly<Unit>(() => _remote.forgetPassword(params));

  @override
  Future<Either<Failure, AuthSession>> resetPassword(
      ResetPasswordParams params) =>
      _persist(onlineOnly<AuthSession>(() => _remote.resetPassword(params)));

  @override
  Future<Either<Failure, AuthSession>> changePassword(
      ChangePasswordParams params) =>
      _persist(onlineOnly<AuthSession>(() => _remote.changePassword(params)));
}