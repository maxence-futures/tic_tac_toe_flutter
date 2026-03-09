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
      profiles: profilesResult.fold((_) => [], (p) => p),
      activeProfile: activeResult.fold((_) => null, (p) => p),
    );
  }

  Future<void> addProfile(String name) async {
    final profile = PlayerProfile(name: name.trim());
    await ref.read(playerProfileRepositoryProvider).addProfile(profile);
    ref.invalidateSelf();
  }

  Future<void> removeProfile(String name) async {
    await ref.read(playerProfileRepositoryProvider).removeProfile(name);
    ref.invalidateSelf();
  }

  Future<void> setActiveProfile(PlayerProfile profile) async {
    await ref.read(playerProfileRepositoryProvider).setActiveProfile(profile);
    ref.invalidateSelf();
  }
}
