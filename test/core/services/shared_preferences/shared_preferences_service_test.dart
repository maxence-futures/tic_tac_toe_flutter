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

    test('returns null for a missing key', () async {
      expect(await service.getString('missing'), isNull);
    });

    test('remove deletes the key', () async {
      await service.setString('key', 'value');
      await service.remove('key');
      expect(await service.getString('key'), isNull);
    });
  });
}
