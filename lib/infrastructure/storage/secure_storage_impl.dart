import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mustore/core/storage/secure_storage.dart';

class SecureStorageImpl implements SecureStorage {
  SecureStorageImpl([FlutterSecureStorage? storage])
      : _storage = storage ??
      const FlutterSecureStorage(
        aOptions: AndroidOptions(
          resetOnError: true,
        ),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      );

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  @override
  Future<void> delete(String key) => _storage.delete(key: key);

  @override
  Future<void> clear() => _storage.deleteAll();

  @override
  Future<T?> readJson<T>(
      String key,
      T Function(Map<String, dynamic> json) fromJson,
      ) async {
    final raw = await _storage.read(key: key);
    if (raw == null) return null;
    try {
      return fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      await _storage.delete(key: key);
      return null;
    }
  }

  @override
  Future<void> writeJson(String key, Map<String, dynamic> json) =>
      _storage.write(key: key, value: jsonEncode(json));
}