import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_move.freezed.dart';
part 'game_move.g.dart';

/// A single move made during a game.
///
/// [position] is a cell index from 0 to 8 (row-major order).
/// [symbol] is either `'X'` (player) or `'O'` (CPU).
@freezed
abstract class GameMove with _$GameMove {
  const factory GameMove({
    required int position,
    required String symbol,
    required bool isCpu,
    required DateTime timestamp,
  }) = _GameMove;

  factory GameMove.fromJson(Map<String, dynamic> json) =>
      _$GameMoveFromJson(json);
}
