import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../game/domain/entities/difficulty.dart';
import '../../../game/domain/entities/game_move.dart';

part 'game_record.freezed.dart';

/// A fully hydrated game record loaded from the local database.
@freezed
abstract class GameRecord with _$GameRecord {
  const factory GameRecord({
    required int id,
    required String playerName,
    required Difficulty difficulty,

    /// `'win'`, `'loss'`, or `'draw'`.
    required String result,
    required List<GameMove> moves,
    required DateTime playedAt,
  }) = _GameRecord;
}
