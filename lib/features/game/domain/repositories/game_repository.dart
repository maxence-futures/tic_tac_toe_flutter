import 'package:dartz/dartz.dart';

import '../entities/difficulty.dart';
import '../entities/game_move.dart';

abstract interface class GameRepository {
  Future<Either<Exception, Unit>> saveGame({
    required String playerName,
    required Difficulty difficulty,
    required String result,
    required List<GameMove> moves,
    required DateTime playedAt,
  });
}
