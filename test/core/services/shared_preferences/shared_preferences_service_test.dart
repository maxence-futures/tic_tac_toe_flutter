import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:tic_tac_toe_flutter/core/services/shared_preferences/impl/shared_preferences_service_impl.dart';
import 'package:tic_tac_toe_flutter/core/services/shared_preferences/shared_preferences_service.dart';

void main() {
  group('SharedPreferencesServiceImpl', () {
    late SharedPreferencesService service;

    setUp(() {
      SharedPreferencesAsyncPlatform.instance =
          InMemorySharedPreferencesAsync.empty();
      service = SharedPreferencesServiceImpl(SharedPreferencesAsync());
    });

    test('sets and gets a String', () async {
      await service.setString('key', 'hello');
      expect(await service.getString('key'), 'hello');
    });

    test('returns null for a missing String key', () async {
      expect(await service.getString('missing'), isNull);
    });

    test('sets and gets an int', () async {
      await service.setInt('key', 42);
      expect(await service.getInt('key'), 42);
    });

    test('sets and gets a double', () async {
      await service.setDouble('key', 3.14);
      expect(await service.getDouble('key'), 3.14);
    });

    test('sets and gets a bool', () async {
      await service.setBool('key', true);
      expect(await service.getBool('key'), isTrue);
    });

    test('sets and gets a string list', () async {
      await service.setStringList('key', ['a', 'b', 'c']);
      expect(await service.getStringList('key'), ['a', 'b', 'c']);
    });

    test('containsKey returns true after a write', () async {
      await service.setString('key', 'value');
      expect(await service.containsKey('key'), isTrue);
    });

    test('containsKey returns false for an absent key', () async {
      expect(await service.containsKey('absent'), isFalse);
    });

    test('remove deletes the key', () async {
      await service.setString('key', 'value');
      await service.remove('key');
      expect(await service.containsKey('key'), isFalse);
    });

    test('clear empties all keys', () async {
      await service.setString('k1', 'v1');
      await service.setInt('k2', 2);
      await service.clear();
      expect(await service.getKeys(), isEmpty);
    });

    test('getKeys returns all stored keys', () async {
      await service.setString('a', '1');
      await service.setString('b', '2');
      expect(await service.getKeys(), containsAll(['a', 'b']));
    });
  });
}
