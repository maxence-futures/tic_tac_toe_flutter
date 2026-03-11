import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

import 'package:tic_tac_toe_flutter/core/database/app_database.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/difficulty.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/game_move.dart';
import 'package:tic_tac_toe_flutter/features/history/domain/entities/game_record.dart';
import 'package:tic_tac_toe_flutter/features/history/domain/repositories/history_repository.dart';

final class HistoryRepositoryImpl implements HistoryRepository {
  const HistoryRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<Either<Exception, List<GameRecord>>> getHistory() async {
    try {
      final rows = await (_db.select(
        _db.gameRecordDriftModel,
      )..orderBy([(r) => OrderingTerm.desc(r.playedAt)])).get();
      return Right(rows.map((row) => _fromRow(row)).toList());
    } catch (e) {
      return Left(Exception('Failed to load history: $e'));
    }
  }

  @override
  Future<Either<Exception, Unit>> deleteGame(int id) async {
    try {
      await (_db.delete(
        _db.gameRecordDriftModel,
      )..where((r) => r.id.equals(id))).go();
      return const Right(unit);
    } catch (e) {
      return Left(Exception('Failed to delete game: $e'));
    }
  }

  @override
  Future<Either<Exception, Unit>> clearHistory() async {
    try {
      await _db.delete(_db.gameRecordDriftModel).go();
      return const Right(unit);
    } catch (e) {
      return Left(Exception('Failed to clear history: $e'));
    }
  }

  // ---------------------------------------------------------------------------

  GameRecord _fromRow(GameRecordDriftModelData row) {
    final rawMoves = jsonDecode(row.movesJson) as List<dynamic>;
    return GameRecord(
      id: row.id,
      playerName: row.playerName,
      difficulty: Difficulty.values.byName(row.difficulty),
      result: row.result,
      moves: rawMoves
          .map((e) => GameMove.fromJson(e as Map<String, dynamic>))
          .toList(),
      playedAt: row.playedAt,
    );
  }
}
