import 'package:dartz/dartz.dart';

import 'package:tic_tac_toe_flutter/features/history/domain/entities/game_record.dart';

abstract interface class HistoryRepository {
  /// Returns all games sorted by [playedAt] descending.
  Future<Either<Exception, List<GameRecord>>> getHistory();

  Future<Either<Exception, Unit>> deleteGame(int id);

  /// Deletes every game record.
  Future<Either<Exception, Unit>> clearHistory();
}
