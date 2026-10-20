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

  factory AuthSessionModel.fromEntity(AuthSession s) => AuthSessionModel(
    firstName: s.firstName,
    lastName: s.lastName,
    phoneNumber: s.phoneNumber,
    email: s.email,
    loginProvider: s.loginProvider,
    profilePictureUrl: s.profilePictureUrl,
    isValidated: s.isValidated,
    roles: s.roles,
    accessToken: s.accessToken,
    accessTokenExpirationDate: s.accessTokenExpirationDate,
    refreshToken: s.refreshToken,
    refreshTokenExpirationDate: s.refreshTokenExpirationDate,
  );

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) =>
      AuthSessionModel(
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        phoneNumber: json['phoneNumber'] as String?,
        email: json['email'] as String,
        loginProvider: LoginProvider.fromJson(json['loginProvider'] as String),
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

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'phoneNumber': phoneNumber,
    'email': email,
    'loginProvider': loginProvider.value,
    'profilePictureUrl': profilePictureUrl,
    'isValidated': isValidated,
    'roles': roles,
    'accessToken': accessToken,
    'accessTokenExpirationDate': accessTokenExpirationDate.toIso8601String(),
    'refreshToken': refreshToken,
    'refreshTokenExpirationDate':
    refreshTokenExpirationDate.toIso8601String(),
  };
}