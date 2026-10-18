import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/features/auth/domain/entities/auth_session.dart';
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

abstract interface class AuthRepository {
  Future<Either<Failure, AuthSession>> login(LoginParams params);
  Future<Either<Failure, Unit>> register(RegisterParams params);
  Future<Either<Failure, AuthSession>> verifyEmail(VerifyEmailParams params);
  Future<Either<Failure, Unit>> resendOtp(ResendOtpParams params);
  Future<Either<Failure, AuthSession>> externalLogin(ExternalLoginParams params);
  Future<Either<Failure, AuthSession>> refreshToken(RefreshTokenParams params);
  Future<Either<Failure, Unit>> revokeSession(RevokeSessionParams params);
  Future<Either<Failure, Unit>> forgetPassword(ForgetPasswordParams params);
  Future<Either<Failure, AuthSession>> resetPassword(ResetPasswordParams params);
  Future<Either<Failure, AuthSession>> changePassword(ChangePasswordParams params);
}