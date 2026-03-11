import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tic_tac_toe_flutter/core/domain/game_rules/board_rules.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/difficulty.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/game_move.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/game_status.dart';

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
    required GameStatus gameStatus,
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
  }) => GameState(
    board: List.filled(9, null),
    currentSymbol: 'X',
    gameStatus: GameStatus.playing(),
    moves: const [],
    difficulty: difficulty,
    playerName: playerName,
  );
}

extension GameStateRules on GameState {
  /// Returns true when the human player is allowed to play at [position].
  bool canPlayerMove(int position) =>
      gameStatus is GameStatusPlaying &&
      !isCpuThinking &&
      board[position] == null &&
      currentSymbol == 'X';

  /// Returns a new state with [symbol] placed at [pos] and the move recorded.
  GameState withMove(int pos, String symbol, {required bool isCpu}) {
    final newBoard = List<String?>.from(board)..[pos] = symbol;
    final move = GameMove(
      position: pos,
      symbol: symbol,
      isCpu: isCpu,
      timestamp: DateTime.now(),
    );
    return copyWith(board: newBoard, moves: [...moves, move]);
  }

  /// Returns a new state with [gameStatus] updated to won, draw, or unchanged.
  GameState evaluate() {
    final line = BoardRules.findWinningLine(board);
    if (line != null) {
      return copyWith(
        gameStatus: GameStatus.won(winner: board[line[0]]!),
        winningPositions: line,
      );
    }
    if (!board.contains(null)) {
      return copyWith(gameStatus: const GameStatus.draw());
    }
    return this;
  }
}
