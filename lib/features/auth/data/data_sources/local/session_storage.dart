import 'package:mustore/features/auth/domain/entities/auth_session.dart';

abstract interface class SessionStorage {
  Future<AuthSession?> read();
  Future<void> save(AuthSession session);
  Future<void> clear();
}