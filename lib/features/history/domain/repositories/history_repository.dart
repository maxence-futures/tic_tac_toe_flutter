import 'package:dartz/dartz.dart';

import '../entities/game_record.dart';

abstract interface class HistoryRepository {
  /// Returns all games sorted by [playedAt] descending.
  Future<Either<Exception, List<GameRecord>>> getHistory();

  Future<Either<Exception, Unit>> deleteGame(int id);
}
