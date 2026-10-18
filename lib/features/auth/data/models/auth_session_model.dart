import 'package:mustore/features/auth/domain/entities/auth_session.dart';
import 'package:mustore/features/auth/domain/enums/login_provider.dart';

class AuthSessionModel extends AuthSession {
  const AuthSessionModel({
    required super.firstName,
    required super.lastName,
    super.phoneNumber,
    required super.email,
    required super.loginProvider,
    required super.profilePictureUrl,
    required super.isValidated,
    required super.roles,
    required super.accessToken,
    required super.accessTokenExpirationDate,
    required super.refreshToken,
    required super.refreshTokenExpirationDate,
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) =>
      AuthSessionModel(
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        phoneNumber: json['phoneNumber'] as String?,
        email: json['email'] as String,
        loginProvider: LoginProviderX.fromJson(json['loginProvider'] as String),
        profilePictureUrl: json['profilePictureUrl'] as String,
        isValidated: json['isValidated'] as bool,
        roles: (json['roles'] as List).cast<String>(),
        accessToken: json['accessToken'] as String,
        accessTokenExpirationDate:
        DateTime.parse(json['accessTokenExpirationDate'] as String),
        refreshToken: json['refreshToken'] as String,
        refreshTokenExpirationDate:
        DateTime.parse(json['refreshTokenExpirationDate'] as String),
      );
}