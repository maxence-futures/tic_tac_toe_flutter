import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tic_tac_toe_flutter/core/services/providers/services_providers.dart';
import 'package:tic_tac_toe_flutter/features/player/data/repositories/player_profile_repository_impl.dart';
import 'package:tic_tac_toe_flutter/features/player/domain/entities/player_profile.dart';
import 'package:tic_tac_toe_flutter/features/player/domain/entities/player_state.dart';
import 'package:tic_tac_toe_flutter/features/player/domain/repositories/player_profile_repository.dart';

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
      profiles: profilesResult.fold((e) {
        ref.read(errorTrackingServiceProvider).captureException(e);
        throw e;
      }, (p) => p),
      activeProfile: activeResult.fold((e) {
        ref.read(errorTrackingServiceProvider).captureException(e);
        throw e;
      }, (p) => p),
    );
  }

  Future<void> addProfile(String name) async {
    final profile = PlayerProfile(name: name.trim());
    final result = await ref
        .read(playerProfileRepositoryProvider)
        .addProfile(profile);
    result.fold((e) {
      ref.read(errorTrackingServiceProvider).captureException(e);
      throw e;
    }, (_) => ref.invalidateSelf());
  }

  Future<void> removeProfile(String name) async {
    final result = await ref
        .read(playerProfileRepositoryProvider)
        .removeProfile(name);
    result.fold((e) {
      ref.read(errorTrackingServiceProvider).captureException(e);
      throw e;
    }, (_) => ref.invalidateSelf());
  }

  Future<void> setActiveProfile(PlayerProfile profile) async {
    final result = await ref
        .read(playerProfileRepositoryProvider)
        .setActiveProfile(profile);
    result.fold((e) {
      ref.read(errorTrackingServiceProvider).captureException(e);
      throw e;
    }, (_) => ref.invalidateSelf());
  }
}
