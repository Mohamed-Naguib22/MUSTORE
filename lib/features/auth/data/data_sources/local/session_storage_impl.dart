import 'package:mustore/core/storage/secure_storage.dart';
import 'package:mustore/core/storage/storage_keys.dart';
import 'package:mustore/features/auth/data/data_sources/local/session_storage.dart';
import 'package:mustore/features/auth/data/models/auth_session_model.dart';
import 'package:mustore/features/auth/domain/entities/auth_session.dart';

class SessionStorageImpl implements SessionStorage {
  SessionStorageImpl(this._storage);

  static const _key = StorageKeys.authSession;

  final SecureStorage _storage;
  AuthSession? _cache;
  bool _loaded = false;

  @override
  Future<AuthSession?> read() async {
    if (_loaded) return _cache;
    _cache = await _storage.readJson(_key, AuthSessionModel.fromJson);
    _loaded = true;
    return _cache;
  }

  @override
  Future<void> save(AuthSession session) async {
    _cache = session;
    _loaded = true;
    await _storage.writeJson(_key, AuthSessionModel.fromEntity(session).toJson());
  }

  @override
  Future<void> clear() async {
    _cache = null;
    _loaded = true;
    await _storage.delete(_key);
  }
}