import 'package:dartz/dartz.dart';

import '../entities/player_profile.dart';

abstract interface class PlayerProfileRepository {
  Future<Either<Exception, List<PlayerProfile>>> getProfiles();
  Future<Either<Exception, Unit>> addProfile(PlayerProfile profile);
  Future<Either<Exception, Unit>> removeProfile(String name);
  Future<Either<Exception, PlayerProfile?>> getActiveProfile();
  Future<Either<Exception, Unit>> setActiveProfile(PlayerProfile profile);
}
