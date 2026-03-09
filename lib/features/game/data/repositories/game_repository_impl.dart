import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/difficulty.dart';
import '../../domain/entities/game_move.dart';
import '../../domain/repositories/game_repository.dart';

final class GameRepositoryImpl implements GameRepository {
  const GameRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<Either<Exception, Unit>> saveGame({
    required String playerName,
    required Difficulty difficulty,
    required String result,
    required List<GameMove> moves,
    required DateTime playedAt,
  }) async {
    try {
      await _db
          .into(_db.gameRecordDriftModel)
          .insert(
            GameRecordDriftModelCompanion.insert(
              playerName: playerName,
              difficulty: difficulty.name,
              result: result,
              movesJson: jsonEncode(moves.map((m) => m.toJson()).toList()),
              playedAt: playedAt,
            ),
          );
      return const Right(unit);
    } catch (e) {
      return Left(Exception('Failed to save game: $e'));
    }
  }
}
