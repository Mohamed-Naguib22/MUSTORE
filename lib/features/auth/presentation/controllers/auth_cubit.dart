import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/services/auth/external_auth_service.dart';
import 'package:mustore/core/services/encryption/otp_encryption_service.dart';
import 'package:mustore/core/services/encryption/password_encryption_service.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/utils/mixins/safe_emit_mixin.dart';
import 'package:mustore/features/auth/data/data_sources/local/session_storage.dart';
import 'package:mustore/features/auth/domain/entities/auth_session.dart';
import 'package:mustore/features/auth/domain/enums/auth_status.dart';
import 'package:mustore/features/auth/domain/enums/login_provider.dart';
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
import 'package:mustore/features/profile/domain/enums/gender.dart';

class AuthCubit extends Cubit<AuthState> with SafeEmitMixin<AuthState> {

  final SessionStorage _sessions;
  final PasswordEncryptionService _passwordEncryption;
  final OtpEncryptionService _otpEncryptionService;
  final ExternalAuthService _externalAuth;

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
    required SessionStorage sessionStorage,
    required SessionEvents sessionEvents,
    required PasswordEncryptionService passwordEncryption,
    required OtpEncryptionService otpEncryptionService,
    required ExternalAuthService externalAuthService,
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
        _passwordEncryption = passwordEncryption,
        _otpEncryptionService = otpEncryptionService,
        _externalAuth = externalAuthService,
        _sessions = sessionStorage,
        super(const AuthState()) {
    _expiredSub = safeSubscribe(sessionEvents.stream, (event) {
      if (event == SessionEvent.expired) {
        safeEmit(state.copyWith(
          status: RequestStatus.success,
          action: AuthAction.revokeSession,
          authStatus: AuthStatus.unauthenticated,
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

  Future<AuthSession?> loadSession() async {
    if (state.session != null) return state.session;

    final session = await _sessions.read();
    if (session != null) safeEmit(state.copyWith(session: session));
    return session;
  }

  Future<void> login({required String email, required String password}) =>
      _runSession(
        AuthAction.login,
            () => _login(
          LoginParams(
            email: email,
            encryptedPassword: _passwordEncryption.encrypt(password),
          ),
        ),
      );

  Future<void> verifyEmail({required String email, required String otp}) =>
      _runSession(
        AuthAction.verifyEmail,
            () => _verifyEmail(
          VerifyEmailParams(
            email: email,
            encryptedOtp: _otpEncryptionService.encrypt(otp),
          ),
        ),
      );

  Future<void> externalLogin(LoginProvider provider) async {
    safeEmit(state.copyWith(
      status: RequestStatus.loading,
      action: AuthAction.externalLogin,
    ));

    final signIn = await _externalAuth.signIn(provider);

    await signIn.fold(
          (failure) async => safeEmit(state.copyWith(
        status: RequestStatus.failure,
        failure: failure,
      )),
          (idToken) async {
        if (idToken == null) {
          return safeEmit(state.copyWith(status: RequestStatus.initial));
        }
        await _runSession(
          AuthAction.externalLogin,
              () => _externalLogin(
            ExternalLoginParams(idToken: idToken, loginProvider: provider),
          ),
        );
      },
    );
  }

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) =>
      _runSession(
        AuthAction.resetPassword,
            () => _resetPassword(
          ResetPasswordParams(
            email: email,
            encryptedOtp: _otpEncryptionService.encrypt(otp),
            newPasswordEncrypted: _passwordEncryption.encrypt(newPassword),
          ),
        ),
      );

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) =>
      _runSession(
        AuthAction.changePassword,
            () => _changePassword(
          ChangePasswordParams(
            oldPasswordEncrypted: _passwordEncryption.encrypt(currentPassword),
            newPasswordEncrypted: _passwordEncryption.encrypt(newPassword),
          ),
        ),
      );

  Future<void> refreshToken() async {
    final session = await _sessions.read();
    if (session == null) return;
    await _runSession(
      AuthAction.refreshToken,
          () => _refreshToken(
        RefreshTokenParams(refreshToken: session.refreshToken),
      ),
    );
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String password,
    required Gender gender,
  }) =>
      _runUnit(
        AuthAction.register,
            () => _register(
          RegisterParams(
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            email: email,
            encryptedPassword: _passwordEncryption.encrypt(password),
            gender: gender,
          ),
        ),
      );

  Future<void> resendOtp(ResendOtpParams params) =>
      _runUnit(AuthAction.resendOtp, () => _resendOtp(params));

  Future<void> forgetPassword(ForgetPasswordParams params) =>
      _runUnit(AuthAction.forgetPassword, () => _forgetPassword(params));

  Future<void> logout() async {
    safeEmit(state.copyWith(
      status: RequestStatus.loading,
      action: AuthAction.revokeSession,
    ));

    final session = await _sessions.read();
    if (session != null) {
      await _revokeSession(
        RevokeSessionParams(refreshToken: session.refreshToken),
      );
    }

    safeEmit(state.copyWith(
      status: RequestStatus.success,
      action: AuthAction.revokeSession,
      authStatus: AuthStatus.unauthenticated,
      clearSession: true,
    ));
  }

  Future<void> restoreSession() async {
    final session = await _sessions.read();
    final now = DateTime.now();

    if (session == null || !session.refreshTokenExpirationDate.isAfter(now)) {
      await _sessions.clear();
      return safeEmit(state.copyWith(authStatus: AuthStatus.unauthenticated));
    }

    if (session.accessTokenExpirationDate.isAfter(now)) {
      return safeEmit(state.copyWith(
        session: session,
        authStatus: AuthStatus.authenticated,
      ));
    }

    final result = await _refreshToken(
      RefreshTokenParams(refreshToken: session.refreshToken),
    );

    await result.fold(
          (failure) async {
        if (failure.isUnauthorized) {
          await _sessions.clear();
          safeEmit(state.copyWith(authStatus: AuthStatus.unauthenticated));
        } else {
          safeEmit(state.copyWith(
            session: session,
            authStatus: AuthStatus.authenticated,
          ));
        }
      },
          (fresh) async => safeEmit(state.copyWith(
        session: fresh,
        authStatus: AuthStatus.authenticated,
      )),
    );
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
      onRight: (s) => state.copyWith(
        status: RequestStatus.success,
        session: s,
        authStatus: AuthStatus.authenticated,
      ),
    );
  }

  Future<void> syncProfile({
    required String firstName,
    required String lastName,
    String? profilePictureUrl,
  }) async {
    final current = state.session;
    if (current == null) return;

    final updated = current.copyWith(
      firstName: firstName,
      lastName: lastName,
      profilePictureUrl: profilePictureUrl,
    );

    if (updated == current) return;

    safeEmit(state.copyWith(session: updated));
    await _sessions.save(updated);
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