/// Contract for persistent key-value storage.
abstract interface class SharedPreferencesService {
  // --- Readers ---

  Future<String?> getString(String key);
  Future<int?> getInt(String key);
  Future<double?> getDouble(String key);
  Future<bool?> getBool(String key);
  Future<List<String>?> getStringList(String key);

  // --- Writers ---

  Future<void> setString(String key, String value);
  Future<void> setInt(String key, int value);
  Future<void> setDouble(String key, double value);
  Future<void> setBool(String key, bool value);
  Future<void> setStringList(String key, List<String> value);

  // --- Management ---

  Future<void> remove(String key);
  Future<void> clear();
  Future<bool> containsKey(String key);
  Future<Set<String>> getKeys();
}
