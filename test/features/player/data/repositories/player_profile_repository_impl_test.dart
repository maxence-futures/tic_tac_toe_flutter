import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:tic_tac_toe_flutter/core/services/shared_preferences/impl/shared_preferences_service_impl.dart';
import 'package:tic_tac_toe_flutter/features/player/data/repositories/player_profile_repository_impl.dart';
import 'package:tic_tac_toe_flutter/features/player/domain/entities/player_profile.dart';

void main() {
  late PlayerProfileRepositoryImpl repo;

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    repo = PlayerProfileRepositoryImpl(
      SharedPreferencesServiceImpl(SharedPreferencesAsync()),
    );
  });

  // -------------------------------------------------------------------------
  // getProfiles
  // -------------------------------------------------------------------------

  group('getProfiles', () {
    test('returns empty list when nothing is stored', () async {
      final result = await repo.getProfiles();

      result.fold(
        (_) => fail('Expected Right'),
        (profiles) => expect(profiles, isEmpty),
      );
    });

    test('returns all previously saved profiles', () async {
      await repo.addProfile(const PlayerProfile(name: 'Alice'));
      await repo.addProfile(const PlayerProfile(name: 'Bob'));

      final result = await repo.getProfiles();

      result.fold((_) => fail('Expected Right'), (profiles) {
        expect(profiles.map((p) => p.name), containsAll(['Alice', 'Bob']));
      });
    });
  });

  // -------------------------------------------------------------------------
  // addProfile
  // -------------------------------------------------------------------------

  group('addProfile', () {
    test('adds a new profile', () async {
      final result = await repo.addProfile(const PlayerProfile(name: 'Alice'));

      expect(result, const Right(unit));
      final profiles = await repo.getProfiles();
      profiles.fold(
        (_) => fail('Expected Right'),
        (list) => expect(list.any((p) => p.name == 'Alice'), isTrue),
      );
    });

    test('is idempotent — duplicate name is silently ignored', () async {
      await repo.addProfile(const PlayerProfile(name: 'Alice'));
      await repo.addProfile(const PlayerProfile(name: 'Alice'));

      final result = await repo.getProfiles();
      result.fold(
        (_) => fail('Expected Right'),
        (list) => expect(list.where((p) => p.name == 'Alice'), hasLength(1)),
      );
    });
  });

  // -------------------------------------------------------------------------
  // removeProfile
  // -------------------------------------------------------------------------

  group('removeProfile', () {
    test('removes an existing profile', () async {
      await repo.addProfile(const PlayerProfile(name: 'Alice'));
      await repo.addProfile(const PlayerProfile(name: 'Bob'));

      final result = await repo.removeProfile('Alice');

      expect(result, const Right(unit));
      final profiles = await repo.getProfiles();
      profiles.fold((_) => fail('Expected Right'), (list) {
        expect(list.any((p) => p.name == 'Alice'), isFalse);
        expect(list.any((p) => p.name == 'Bob'), isTrue);
      });
    });

    test('clears the active profile when removing the active player', () async {
      await repo.addProfile(const PlayerProfile(name: 'Alice'));
      await repo.setActiveProfile(const PlayerProfile(name: 'Alice'));

      await repo.removeProfile('Alice');

      final activeResult = await repo.getActiveProfile();
      activeResult.fold(
        (_) => fail('Expected Right'),
        (active) => expect(active, isNull),
      );
    });

    test(
      'does not touch the active profile when removing a different player',
      () async {
        await repo.addProfile(const PlayerProfile(name: 'Alice'));
        await repo.addProfile(const PlayerProfile(name: 'Bob'));
        await repo.setActiveProfile(const PlayerProfile(name: 'Alice'));

        await repo.removeProfile('Bob');

        final activeResult = await repo.getActiveProfile();
        activeResult.fold(
          (_) => fail('Expected Right'),
          (active) => expect(active?.name, 'Alice'),
        );
      },
    );
  });

  // -------------------------------------------------------------------------
  // getActiveProfile
  // -------------------------------------------------------------------------

  group('getActiveProfile', () {
    test('returns null when no active profile is set', () async {
      final result = await repo.getActiveProfile();

      result.fold(
        (_) => fail('Expected Right'),
        (active) => expect(active, isNull),
      );
    });

    test('returns the active profile after it has been set', () async {
      await repo.addProfile(const PlayerProfile(name: 'Alice'));
      await repo.setActiveProfile(const PlayerProfile(name: 'Alice'));

      final result = await repo.getActiveProfile();

      result.fold(
        (_) => fail('Expected Right'),
        (active) => expect(active?.name, 'Alice'),
      );
    });

    test('returns null when active name points to a removed profile', () async {
      await repo.addProfile(const PlayerProfile(name: 'Alice'));
      await repo.setActiveProfile(const PlayerProfile(name: 'Alice'));
      await repo.removeProfile('Alice');

      final result = await repo.getActiveProfile();

      result.fold(
        (_) => fail('Expected Right'),
        (active) => expect(active, isNull),
      );
    });
  });

  // -------------------------------------------------------------------------
  // setActiveProfile
  // -------------------------------------------------------------------------

  group('setActiveProfile', () {
    test('persists the active profile name', () async {
      await repo.addProfile(const PlayerProfile(name: 'Bob'));

      final result = await repo.setActiveProfile(
        const PlayerProfile(name: 'Bob'),
      );

      expect(result, const Right(unit));
      final activeResult = await repo.getActiveProfile();
      activeResult.fold(
        (_) => fail('Expected Right'),
        (active) => expect(active?.name, 'Bob'),
      );
    });

    test('replaces the previously active profile', () async {
      await repo.addProfile(const PlayerProfile(name: 'Alice'));
      await repo.addProfile(const PlayerProfile(name: 'Bob'));
      await repo.setActiveProfile(const PlayerProfile(name: 'Alice'));
      await repo.setActiveProfile(const PlayerProfile(name: 'Bob'));

      final result = await repo.getActiveProfile();
      result.fold(
        (_) => fail('Expected Right'),
        (active) => expect(active?.name, 'Bob'),
      );
    });
  });
}
