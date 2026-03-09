import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_flutter/core/database/app_database.dart';

void main() {
  group('AppDatabase', () {
    late AppDatabase database;

    setUp(() {
      database = AppDatabase.forTesting(NativeDatabase.memory());
    });

    tearDown(() async {
      await database.close();
    });

    test('opens successfully with schema version 1', () {
      expect(database, isNotNull);
      expect(database.schemaVersion, 1);
    });

    test('closes without error', () async {
      await expectLater(database.close(), completes);
    });
  });
}
