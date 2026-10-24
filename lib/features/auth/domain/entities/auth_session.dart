import 'package:equatable/equatable.dart';
import 'package:mustore/features/auth/domain/enums/login_provider.dart';

class AuthSession extends Equatable {
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final String email;
  final LoginProvider loginProvider;
  final String profilePictureUrl;
  final bool isValidated;
  final List<String> roles;
  final String accessToken;
  final DateTime accessTokenExpirationDate;
  final String refreshToken;
  final DateTime refreshTokenExpirationDate;

  AuthSession copyWith({
    String? firstName,
    String? lastName,
    String? profilePictureUrl,
  }) =>
      AuthSession(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber,
        email: email,
        loginProvider: loginProvider,
        profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
        isValidated: isValidated,
        roles: roles,
        accessToken: accessToken,
        accessTokenExpirationDate: accessTokenExpirationDate,
        refreshToken: refreshToken,
        refreshTokenExpirationDate: refreshTokenExpirationDate,
      );

  const AuthSession({
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    required this.email,
    required this.loginProvider,
    required this.profilePictureUrl,
    required this.isValidated,
    required this.roles,
    required this.accessToken,
    required this.accessTokenExpirationDate,
    required this.refreshToken,
    required this.refreshTokenExpirationDate,
  });

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    phoneNumber,
    email,
    loginProvider,
    profilePictureUrl,
    isValidated,
    roles,
    accessToken,
    accessTokenExpirationDate,
    refreshToken,
    refreshTokenExpirationDate,
  ];
}