import 'package:dartz/dartz.dart';

import 'package:tic_tac_toe_flutter/features/player/domain/entities/player_profile.dart';

/// Repository for managing player profiles.
abstract interface class PlayerProfileRepository {
  Future<Either<Exception, List<PlayerProfile>>> getProfiles();
  Future<Either<Exception, Unit>> addProfile(PlayerProfile profile);
  Future<Either<Exception, Unit>> removeProfile(String name);
  Future<Either<Exception, PlayerProfile?>> getActiveProfile();
  Future<Either<Exception, Unit>> setActiveProfile(PlayerProfile profile);
}
