import 'package:shared_preferences/shared_preferences.dart';

import '../shared_preferences_service.dart';

/// Concrete implementation of [SharedPreferencesService] wrapping
/// [SharedPreferencesAsync].
class SharedPreferencesServiceImpl implements SharedPreferencesService {
  const SharedPreferencesServiceImpl(this._prefs);

  final SharedPreferencesAsync _prefs;

  // --- Readers ---

  @override
  Future<String?> getString(String key) => _prefs.getString(key);

  @override
  Future<int?> getInt(String key) => _prefs.getInt(key);

  @override
  Future<double?> getDouble(String key) => _prefs.getDouble(key);

  @override
  Future<bool?> getBool(String key) => _prefs.getBool(key);

  @override
  Future<List<String>?> getStringList(String key) =>
      _prefs.getStringList(key);

  // --- Writers ---

  @override
  Future<void> setString(String key, String value) =>
      _prefs.setString(key, value);

  @override
  Future<void> setInt(String key, int value) => _prefs.setInt(key, value);

  @override
  Future<void> setDouble(String key, double value) =>
      _prefs.setDouble(key, value);

  @override
  Future<void> setBool(String key, bool value) => _prefs.setBool(key, value);

  @override
  Future<void> setStringList(String key, List<String> value) =>
      _prefs.setStringList(key, value);

  // --- Management ---

  @override
  Future<void> remove(String key) => _prefs.remove(key);

  @override
  Future<void> clear() => _prefs.clear();

  @override
  Future<bool> containsKey(String key) => _prefs.containsKey(key);

  @override
  Future<Set<String>> getKeys() => _prefs.getKeys();
}
