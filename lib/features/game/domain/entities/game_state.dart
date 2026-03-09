import 'package:freezed_annotation/freezed_annotation.dart';

import 'difficulty.dart';
import 'game_move.dart';
import 'game_status.dart';

part 'game_state.freezed.dart';

/// Full in-memory state of a running game.
///
/// [board] has 9 slots (indices 0–8, row-major). `null` = empty cell.
/// [currentSymbol] alternates between `'X'` (player) and `'O'` (CPU).
/// [winningPositions] is populated when [status] is [GameStatusWon].
@freezed
abstract class GameState with _$GameState {
  const factory GameState({
    required List<String?> board,
    required String currentSymbol,
    required GameStatus status,
    required List<GameMove> moves,
    required Difficulty difficulty,
    required String playerName,
    @Default(false) bool isCpuThinking,
    @Default([]) List<int> winningPositions,
  }) = _GameState;

  const GameState._();

  factory GameState.initial({
    required String playerName,
    required Difficulty difficulty,
  }) =>
      GameState(
        board: List.filled(9, null),
        currentSymbol: 'X',
        status: const GameStatus.playing(),
        moves: const [],
        difficulty: difficulty,
        playerName: playerName,
      );
}
