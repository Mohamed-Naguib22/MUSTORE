abstract interface class SecureStorage {
  Future<String?> read(String key);
  Future<void> write(String key, String value);
  Future<void> delete(String key);
  Future<void> clear();
  Future<T?> readJson<T>(String key, T Function(Map<String, dynamic> json) fromJson,);
  Future<void> writeJson(String key, Map<String, dynamic> json);
}