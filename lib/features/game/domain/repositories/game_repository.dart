import 'package:dartz/dartz.dart';

import 'package:tic_tac_toe_flutter/features/game/domain/entities/difficulty.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/game_move.dart';

abstract interface class GameRepository {
  Future<Either<Exception, Unit>> saveGame({
    required String playerName,
    required Difficulty difficulty,
    required String result,
    required List<GameMove> moves,
    required DateTime playedAt,
  });
}
