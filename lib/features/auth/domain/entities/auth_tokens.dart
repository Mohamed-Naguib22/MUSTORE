import 'package:equatable/equatable.dart';

class AuthTokens extends Equatable {
  const AuthTokens({
    required this.accessToken,
    required this.refreshToken,
    required this.accessTokenExpirationDate,
    required this.refreshTokenExpirationDate,
  });

  final String accessToken;
  final String refreshToken;
  final DateTime accessTokenExpirationDate;
  final DateTime refreshTokenExpirationDate;

  bool get isRefreshTokenExpired =>
      refreshTokenExpirationDate.isBefore(DateTime.now());

  factory AuthTokens.fromJson(Map<String, dynamic> json) => AuthTokens(
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
    accessTokenExpirationDate:
    DateTime.parse(json['accessTokenExpirationDate'] as String),
    refreshTokenExpirationDate:
    DateTime.parse(json['refreshTokenExpirationDate'] as String),
  );

  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'accessTokenExpirationDate': accessTokenExpirationDate.toIso8601String(),
    'refreshTokenExpirationDate':
    refreshTokenExpirationDate.toIso8601String(),
  };

  @override
  List<Object?> get props => [
    accessToken,
    refreshToken,
    accessTokenExpirationDate,
    refreshTokenExpirationDate,
  ];
}