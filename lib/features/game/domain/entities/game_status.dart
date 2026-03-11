import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_status.freezed.dart';

/// Represents the current outcome state of a game.
@freezed
sealed class GameStatus with _$GameStatus {
  /// The game is still in progress.
  const factory GameStatus.playing() = GameStatusPlaying;

  /// A player won. [winner] is `'X'` (player) or `'O'` (CPU).
  const factory GameStatus.won({required String winner}) = GameStatusWon;

  /// The board is full with no winner.
  const factory GameStatus.draw() = GameStatusDraw;
}
