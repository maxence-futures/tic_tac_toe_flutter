import 'package:shared_preferences/shared_preferences.dart';

import 'package:tic_tac_toe_flutter/core/services/shared_preferences/shared_preferences_service.dart';

/// Concrete implementation of [SharedPreferencesService] wrapping
/// [SharedPreferencesAsync].
class SharedPreferencesServiceImpl implements SharedPreferencesService {
  const SharedPreferencesServiceImpl(this._prefs);

  final SharedPreferencesAsync _prefs;

  @override
  Future<String?> getString(String key) => _prefs.getString(key);

  @override
  Future<void> setString(String key, String value) =>
      _prefs.setString(key, value);

  @override
  Future<void> remove(String key) => _prefs.remove(key);
}
