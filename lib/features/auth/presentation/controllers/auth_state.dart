import 'package:equatable/equatable.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/features/auth/domain/entities/auth_session.dart';

enum AuthAction {
  login,
  register,
  verifyEmail,
  resendOtp,
  externalLogin,
  refreshToken,
  revokeSession,
  forgetPassword,
  resetPassword,
  changePassword,
}

class AuthState extends Equatable {
  const AuthState({
    this.status = RequestStatus.initial,
    this.action,
    this.session,
    this.failure,
  });

  final RequestStatus status;
  final AuthAction? action;
  final AuthSession? session;
  final Failure? failure;

  bool get isAuthenticated => session != null;

  AuthState copyWith({
    RequestStatus? status,
    AuthAction? action,
    AuthSession? session,
    Failure? failure,
    bool clearSession = false,
  }) =>
      AuthState(
        status: status ?? this.status,
        action: action ?? this.action,
        session: clearSession ? null : (session ?? this.session),
        failure: failure,
      );

  @override
  List<Object?> get props => [status, action, session, failure];
}