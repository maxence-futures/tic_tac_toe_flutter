import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/providers/services_providers.dart';
import '../../data/repositories/player_profile_repository_impl.dart';
import '../../domain/entities/player_profile.dart';
import '../../domain/entities/player_state.dart';
import '../../domain/repositories/player_profile_repository.dart';

part 'player_providers.g.dart';

@Riverpod(keepAlive: true)
PlayerProfileRepository playerProfileRepository(Ref ref) {
  return PlayerProfileRepositoryImpl(
    ref.watch(sharedPreferencesServiceProvider),
  );
}

@riverpod
class PlayerNotifier extends _$PlayerNotifier {
  @override
  Future<PlayerState> build() async {
    final repo = ref.watch(playerProfileRepositoryProvider);
    final profilesResult = await repo.getProfiles();
    final activeResult = await repo.getActiveProfile();

    return PlayerState(
      profiles: profilesResult.fold((e) => _track(e), (p) => p),
      activeProfile: activeResult.fold((e) => _track(e), (p) => p),
    );
  }

  Future<void> addProfile(String name) async {
    final result = await ref
        .read(playerProfileRepositoryProvider)
        .addProfile(PlayerProfile(name: name.trim()));
    result.fold((e) => throw _track(e), (_) => ref.invalidateSelf());
  }

  Future<void> removeProfile(String name) async {
    final result = await ref
        .read(playerProfileRepositoryProvider)
        .removeProfile(name);
    result.fold((e) => throw _track(e), (_) => ref.invalidateSelf());
  }

  Future<void> setActiveProfile(PlayerProfile profile) async {
    final result = await ref
        .read(playerProfileRepositoryProvider)
        .setActiveProfile(profile);
    result.fold((e) => throw _track(e), (_) => ref.invalidateSelf());
  }

  /// Forwards [e] to the error tracking service and rethrows it.
  Never _track(Exception e) {
    ref.read(errorTrackingServiceProvider).captureException(e);
    throw e;
  }
}
