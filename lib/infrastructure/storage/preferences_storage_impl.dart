import 'dart:convert';
import 'package:mustore/core/storage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesStorageImpl implements LocalStorage {
  PreferencesStorageImpl([SharedPreferencesAsync? prefs])
      : _prefs = prefs ?? SharedPreferencesAsync();

  final SharedPreferencesAsync _prefs;

  @override
  Future<String?> readString(String key) => _prefs.getString(key);

  @override
  Future<void> writeString(String key, String value) =>
      _prefs.setString(key, value);

  @override
  Future<bool?> readBool(String key) => _prefs.getBool(key);

  @override
  Future<void> writeBool(String key, bool value) => _prefs.setBool(key, value);

  @override
  Future<int?> readInt(String key) => _prefs.getInt(key);

  @override
  Future<void> writeInt(String key, int value) => _prefs.setInt(key, value);

  @override
  Future<double?> readDouble(String key) => _prefs.getDouble(key);

  @override
  Future<void> writeDouble(String key, double value) =>
      _prefs.setDouble(key, value);

  @override
  Future<List<String>?> readStringList(String key) =>
      _prefs.getStringList(key);

  @override
  Future<void> writeStringList(String key, List<String> value) =>
      _prefs.setStringList(key, value);

  @override
  Future<T?> readJson<T>(
      String key,
      T Function(Map<String, dynamic> json) fromJson,
      ) async {
    final raw = await _prefs.getString(key);
    if (raw == null) return null;
    try {
      return fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      await _prefs.remove(key);
      return null;
    }
  }

  @override
  Future<void> writeJson(String key, Map<String, dynamic> json) =>
      _prefs.setString(key, jsonEncode(json));

  @override
  Future<bool> contains(String key) => _prefs.containsKey(key);

  @override
  Future<void> delete(String key) => _prefs.remove(key);

  @override
  Future<void> clear() => _prefs.clear();
}