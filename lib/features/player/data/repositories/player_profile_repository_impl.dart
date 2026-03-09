import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/services/shared_preferences/shared_preferences_service.dart';
import '../../domain/entities/player_profile.dart';
import '../../domain/repositories/player_profile_repository.dart';

const _kProfiles = 'player_profiles';
const _kActiveProfile = 'active_player_name';

final class PlayerProfileRepositoryImpl implements PlayerProfileRepository {
  const PlayerProfileRepositoryImpl(this._prefs);

  final SharedPreferencesService _prefs;

  @override
  Future<Either<Exception, List<PlayerProfile>>> getProfiles() async {
    try {
      final raw = await _prefs.getString(_kProfiles);
      if (raw == null) return const Right([]);
      final list = (jsonDecode(raw) as List)
          .map((e) => PlayerProfile.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(list);
    } catch (e) {
      return Left(Exception('Failed to load profiles: $e'));
    }
  }

  @override
  Future<Either<Exception, Unit>> addProfile(PlayerProfile profile) async {
    try {
      final current = await _loadProfiles();
      if (current.any((p) => p.name == profile.name)) return const Right(unit);
      await _saveProfiles([...current, profile]);
      return const Right(unit);
    } catch (e) {
      return Left(Exception('Failed to add profile: $e'));
    }
  }

  @override
  Future<Either<Exception, Unit>> removeProfile(String name) async {
    try {
      final current = await _loadProfiles();
      await _saveProfiles(current.where((p) => p.name != name).toList());
      final active = await _prefs.getString(_kActiveProfile);
      if (active == name) await _prefs.remove(_kActiveProfile);
      return const Right(unit);
    } catch (e) {
      return Left(Exception('Failed to remove profile: $e'));
    }
  }

  @override
  Future<Either<Exception, PlayerProfile?>> getActiveProfile() async {
    try {
      final name = await _prefs.getString(_kActiveProfile);
      if (name == null) return const Right(null);
      final profiles = await _loadProfiles();
      final match = profiles.where((p) => p.name == name).firstOrNull;
      return Right(match);
    } catch (e) {
      return Left(Exception('Failed to get active profile: $e'));
    }
  }

  @override
  Future<Either<Exception, Unit>> setActiveProfile(
    PlayerProfile profile,
  ) async {
    try {
      await _prefs.setString(_kActiveProfile, profile.name);
      return const Right(unit);
    } catch (e) {
      return Left(Exception('Failed to set active profile: $e'));
    }
  }

  // ---------------------------------------------------------------------------

  Future<List<PlayerProfile>> _loadProfiles() async {
    final raw = await _prefs.getString(_kProfiles);
    if (raw == null) return [];
    return (jsonDecode(raw) as List)
        .map((e) => PlayerProfile.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> _saveProfiles(List<PlayerProfile> profiles) async {
    await _prefs.setString(
      _kProfiles,
      jsonEncode(profiles.map((p) => p.toJson()).toList()),
    );
  }
}
