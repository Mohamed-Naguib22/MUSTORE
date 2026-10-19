import 'package:mustore/core/storage/secure_storage.dart';
import 'package:mustore/core/storage/storage_keys.dart';
import 'package:mustore/features/auth/data/data_sources/local/token_storage.dart';
import 'package:mustore/features/auth/domain/entities/auth_tokens.dart';

class TokenStorageImpl implements TokenStorage {
  TokenStorageImpl(this._storage);

  static const _key = StorageKeys.authTokens;

  final SecureStorage _storage;
  AuthTokens? _cache;
  bool _loaded = false;

  @override
  Future<AuthTokens?> read() async {
    if (_loaded) return _cache;
    _cache = await _storage.readJson(_key, AuthTokens.fromJson);
    _loaded = true;
    return _cache;
  }

  @override
  Future<void> save(AuthTokens tokens) async {
    _cache = tokens;
    _loaded = true;
    await _storage.writeJson(_key, tokens.toJson());
  }

  @override
  Future<void> clear() async {
    _cache = null;
    _loaded = true;
    await _storage.delete(_key);
  }
}