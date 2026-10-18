import 'package:mustore/features/auth/domain/entities/auth_tokens.dart';

abstract interface class TokenStorage {
  Future<AuthTokens?> read();
  Future<void> save(AuthTokens tokens);
  Future<void> clear();
}