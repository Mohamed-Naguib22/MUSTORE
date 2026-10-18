abstract class LocalStorage {
  Future<String?> readString(String key);
  Future<void> writeString(String key, String value);

  Future<bool?> readBool(String key);
  Future<void> writeBool(String key, bool value);

  Future<int?> readInt(String key);
  Future<void> writeInt(String key, int value);

  Future<double?> readDouble(String key);
  Future<void> writeDouble(String key, double value);

  Future<List<String>?> readStringList(String key);
  Future<void> writeStringList(String key, List<String> value);

  Future<T?> readJson<T>(String key, T Function(Map<String, dynamic> json) fromJson,);
  Future<void> writeJson(String key, Map<String, dynamic> json);

  Future<bool> contains(String key);
  Future<void> delete(String key);
  Future<void> clear();
}