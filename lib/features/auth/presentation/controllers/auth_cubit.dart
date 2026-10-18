import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/utils/mixins/safe_emit_mixin.dart';
import 'package:mustore/features/auth/data/data_sources/local/token_storage.dart';
import 'package:mustore/features/auth/domain/entities/auth_session.dart';
import 'package:mustore/features/auth/domain/events/session_event.dart';
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
import 'package:mustore/features/auth/domain/use_cases/change_password_use_case.dart';
import 'package:mustore/features/auth/domain/use_cases/external_login_use_case.dart';
import 'package:mustore/features/auth/domain/use_cases/forget_password_use_case.dart';
import 'package:mustore/features/auth/domain/use_cases/login_use_case.dart';
import 'package:mustore/features/auth/domain/use_cases/refresh_token_use_case.dart';
import 'package:mustore/features/auth/domain/use_cases/register_use_case.dart';
import 'package:mustore/features/auth/domain/use_cases/resend_otp_use_case.dart';
import 'package:mustore/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:mustore/features/auth/domain/use_cases/revoke_session_use_case.dart';
import 'package:mustore/features/auth/domain/use_cases/verify_email_use_case.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_state.dart';

class AuthCubit extends Cubit<AuthState> with SafeEmitMixin<AuthState> {

  final TokenStorage _tokens;
  StreamSubscription<SessionEvent>? _expiredSub;

  AuthCubit({
    required LoginUseCase login,
    required RegisterUseCase register,
    required VerifyEmailUseCase verifyEmail,
    required ResendOtpUseCase resendOtp,
    required ExternalLoginUseCase externalLogin,
    required RefreshTokenUseCase refreshToken,
    required RevokeSessionUseCase revokeSession,
    required ForgetPasswordUseCase forgetPassword,
    required ResetPasswordUseCase resetPassword,
    required ChangePasswordUseCase changePassword,
    required TokenStorage tokenStorage,
    required SessionEvents sessionEvents,
  })  : _login = login,
        _register = register,
        _verifyEmail = verifyEmail,
        _resendOtp = resendOtp,
        _externalLogin = externalLogin,
        _refreshToken = refreshToken,
        _revokeSession = revokeSession,
        _forgetPassword = forgetPassword,
        _resetPassword = resetPassword,
        _changePassword = changePassword,
        _tokens = tokenStorage,
        super(const AuthState()) {
    _expiredSub = safeSubscribe(sessionEvents.stream, (event) {
      if (event == SessionEvent.expired) {
        safeEmit(state.copyWith(
          status: RequestStatus.success,
          action: AuthAction.revokeSession,
          clearSession: true,
        ));
      }
    });
  }

  final LoginUseCase _login;
  final RegisterUseCase _register;
  final VerifyEmailUseCase _verifyEmail;
  final ResendOtpUseCase _resendOtp;
  final ExternalLoginUseCase _externalLogin;
  final RefreshTokenUseCase _refreshToken;
  final RevokeSessionUseCase _revokeSession;
  final ForgetPasswordUseCase _forgetPassword;
  final ResetPasswordUseCase _resetPassword;
  final ChangePasswordUseCase _changePassword;

  Future<void> login(LoginParams params) =>
      _runSession(AuthAction.login, () => _login(params));

  Future<void> verifyEmail(VerifyEmailParams params) =>
      _runSession(AuthAction.verifyEmail, () => _verifyEmail(params));

  Future<void> externalLogin(ExternalLoginParams params) =>
      _runSession(AuthAction.externalLogin, () => _externalLogin(params));

  Future<void> resetPassword(ResetPasswordParams params) =>
      _runSession(AuthAction.resetPassword, () => _resetPassword(params));

  Future<void> changePassword(ChangePasswordParams params) =>
      _runSession(AuthAction.changePassword, () => _changePassword(params));

  Future<void> refreshToken() async {
    final tokens = await _tokens.read();
    if (tokens == null) return;
    await _runSession(
      AuthAction.refreshToken,
          () => _refreshToken(RefreshTokenParams(refreshToken: tokens.refreshToken)),
    );
  }

  Future<void> register(RegisterParams params) =>
      _runUnit(AuthAction.register, () => _register(params));

  Future<void> resendOtp(ResendOtpParams params) =>
      _runUnit(AuthAction.resendOtp, () => _resendOtp(params));

  Future<void> forgetPassword(ForgetPasswordParams params) =>
      _runUnit(AuthAction.forgetPassword, () => _forgetPassword(params));

  Future<void> logout() async {
    safeEmit(state.copyWith(
      status: RequestStatus.loading,
      action: AuthAction.revokeSession,
    ));

    final tokens = await _tokens.read();
    if (tokens != null) {
      await _revokeSession(
        RevokeSessionParams(refreshToken: tokens.refreshToken),
      );
    }

    safeEmit(state.copyWith(
      status: RequestStatus.success,
      action: AuthAction.revokeSession,
      clearSession: true,
    ));
  }

  @override
  Future<void> close() {
    _expiredSub?.cancel();
    return super.close();
  }

  Future<void> _runSession(
      AuthAction action,
      Future<Either<Failure, AuthSession>> Function() call,
      ) async {
    safeEmit(state.copyWith(status: RequestStatus.loading, action: action));

    final result = await call();

    safeFold<Failure, AuthSession>(
      result,
      onLeft: (f) => state.copyWith(status: RequestStatus.failure, failure: f),
      onRight: (s) => state.copyWith(status: RequestStatus.success, session: s),
    );
  }

  Future<void> _runUnit(
      AuthAction action,
      Future<Either<Failure, Unit>> Function() call,
      ) async {
    safeEmit(state.copyWith(status: RequestStatus.loading, action: action));

    final result = await call();

    safeFold<Failure, Unit>(
      result,
      onLeft: (f) => state.copyWith(status: RequestStatus.failure, failure: f),
      onRight: (_) => state.copyWith(status: RequestStatus.success),
    );
  }
}