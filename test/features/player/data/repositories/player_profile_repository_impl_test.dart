import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:tic_tac_toe_flutter/core/services/shared_preferences/impl/shared_preferences_service_impl.dart';
import 'package:tic_tac_toe_flutter/features/player/data/repositories/player_profile_repository_impl.dart';
import 'package:tic_tac_toe_flutter/features/player/domain/entities/player_profile.dart';

void main() {
  late PlayerProfileRepositoryImpl repo;

  const alice = PlayerProfile(name: 'Alice');
  const bob = PlayerProfile(name: 'Bob');

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    repo = PlayerProfileRepositoryImpl(
      SharedPreferencesServiceImpl(SharedPreferencesAsync()),
    );
  });

  // ---------------------------------------------------------------------------
  // getProfiles
  // ---------------------------------------------------------------------------

  group('getProfiles', () {
    test('returns an empty list when nothing is stored', () async {
      final result = await repo.getProfiles();
      result.fold((_) => fail('expected Right'), (p) => expect(p, isEmpty));
    });

    test('returns stored profiles after adding them', () async {
      await repo.addProfile(alice);
      await repo.addProfile(bob);

      final result = await repo.getProfiles();
      result.fold(
        (_) => fail('expected Right'),
        (profiles) {
          expect(profiles.length, 2);
          expect(profiles.map((p) => p.name), containsAll(['Alice', 'Bob']));
        },
      );
    });
  });

  // ---------------------------------------------------------------------------
  // addProfile
  // ---------------------------------------------------------------------------

  group('addProfile', () {
    test('adds a new profile', () async {
      await repo.addProfile(alice);

      final result = await repo.getProfiles();
      result.fold(
        (_) => fail('expected Right'),
        (profiles) => expect(profiles.single.name, 'Alice'),
      );
    });

    test('is idempotent — adding the same name twice does not duplicate', () async {
      await repo.addProfile(alice);
      await repo.addProfile(alice);

      final result = await repo.getProfiles();
      result.fold(
        (_) => fail('expected Right'),
        (profiles) => expect(profiles.length, 1),
      );
    });
  });

  // ---------------------------------------------------------------------------
  // removeProfile
  // ---------------------------------------------------------------------------

  group('removeProfile', () {
    test('removes an existing profile', () async {
      await repo.addProfile(alice);
      await repo.addProfile(bob);
      await repo.removeProfile('Alice');

      final result = await repo.getProfiles();
      result.fold(
        (_) => fail('expected Right'),
        (profiles) {
          expect(profiles.length, 1);
          expect(profiles.single.name, 'Bob');
        },
      );
    });

    test('removing a non-existent profile is a no-op', () async {
      await repo.addProfile(alice);
      await repo.removeProfile('Unknown');

      final result = await repo.getProfiles();
      result.fold(
        (_) => fail('expected Right'),
        (profiles) => expect(profiles.length, 1),
      );
    });

    test('clears the active profile when it matches the removed name', () async {
      await repo.addProfile(alice);
      await repo.setActiveProfile(alice);
      await repo.removeProfile('Alice');

      final result = await repo.getActiveProfile();
      result.fold(
        (_) => fail('expected Right'),
        (active) => expect(active, isNull),
      );
    });

    test('does not clear the active profile when another profile is removed', () async {
      await repo.addProfile(alice);
      await repo.addProfile(bob);
      await repo.setActiveProfile(alice);
      await repo.removeProfile('Bob');

      final result = await repo.getActiveProfile();
      result.fold(
        (_) => fail('expected Right'),
        (active) => expect(active?.name, 'Alice'),
      );
    });
  });

  // ---------------------------------------------------------------------------
  // getActiveProfile
  // ---------------------------------------------------------------------------

  group('getActiveProfile', () {
    test('returns null when no active profile is set', () async {
      final result = await repo.getActiveProfile();
      result.fold((_) => fail('expected Right'), (p) => expect(p, isNull));
    });

    test('returns the profile after setActiveProfile', () async {
      await repo.addProfile(alice);
      await repo.setActiveProfile(alice);

      final result = await repo.getActiveProfile();
      result.fold(
        (_) => fail('expected Right'),
        (p) => expect(p?.name, 'Alice'),
      );
    });

    test('returns null when active profile name no longer exists in profiles', () async {
      await repo.addProfile(alice);
      await repo.setActiveProfile(alice);
      // Remove without going through removeProfile (simulate stale data).
      await repo.removeProfile('Alice');

      final result = await repo.getActiveProfile();
      result.fold(
        (_) => fail('expected Right'),
        (p) => expect(p, isNull),
      );
    });
  });

  // ---------------------------------------------------------------------------
  // setActiveProfile
  // ---------------------------------------------------------------------------

  group('setActiveProfile', () {
    test('sets the active profile', () async {
      await repo.addProfile(alice);
      final result = await repo.setActiveProfile(alice);
      expect(result.isRight(), isTrue);
    });

    test('overwrites a previously set active profile', () async {
      await repo.addProfile(alice);
      await repo.addProfile(bob);
      await repo.setActiveProfile(alice);
      await repo.setActiveProfile(bob);

      final result = await repo.getActiveProfile();
      result.fold(
        (_) => fail('expected Right'),
        (p) => expect(p?.name, 'Bob'),
      );
    });
  });
}
