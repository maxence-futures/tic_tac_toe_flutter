/// Contract for persistent key-value storage.
abstract interface class SharedPreferencesService {
  Future<String?> getString(String key);

  Future<void> setString(String key, String value);

  Future<void> remove(String key);
}
