import 'dart:math';

import '../entities/difficulty.dart';

/// Returns the index (0–8) of the CPU's next move given the current [board].
///
/// Strategy per difficulty level:
/// - [Difficulty.easy]   : random empty cell.
/// - [Difficulty.medium] : 50 % minimax best move, 50 % random.
/// - [Difficulty.hard]   : always minimax best move (unbeatable).
final class GetCpuMoveUsecase {
  const GetCpuMoveUsecase();

  static const _winPatterns = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], // cols
    [0, 4, 8], [2, 4, 6],             // diagonals
  ];

  int call(List<String?> board, Difficulty difficulty) {
    final empties = _emptyCells(board);
    if (empties.isEmpty) return -1;

    switch (difficulty) {
      case Difficulty.easy:
        return _randomMove(empties);
      case Difficulty.medium:
        return _random.nextBool() ? _bestMove(board) : _randomMove(empties);
      case Difficulty.hard:
        return _bestMove(board);
    }
  }

  // ---------------------------------------------------------------------------
  // Minimax
  // ---------------------------------------------------------------------------

  static final _random = Random();

  int _bestMove(List<String?> board) {
    int bestScore = -1000;
    int bestIndex = _emptyCells(board).first;

    for (final i in _emptyCells(board)) {
      final b = List<String?>.from(board)..[i] = 'O';
      final score = _minimax(b, depth: 0, isMaximising: false);
      if (score > bestScore) {
        bestScore = score;
        bestIndex = i;
      }
    }
    return bestIndex;
  }

  int _minimax(
    List<String?> board, {
    required int depth,
    required bool isMaximising,
  }) {
    final winner = _checkWinner(board);
    if (winner == 'O') return 10 - depth;
    if (winner == 'X') return depth - 10;
    if (!board.contains(null)) return 0;

    if (isMaximising) {
      int best = -1000;
      for (final i in _emptyCells(board)) {
        final b = List<String?>.from(board)..[i] = 'O';
        best = max(best, _minimax(b, depth: depth + 1, isMaximising: false));
      }
      return best;
    } else {
      int best = 1000;
      for (final i in _emptyCells(board)) {
        final b = List<String?>.from(board)..[i] = 'X';
        best = min(best, _minimax(b, depth: depth + 1, isMaximising: true));
      }
      return best;
    }
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  int _randomMove(List<int> empties) =>
      empties[_random.nextInt(empties.length)];

  List<int> _emptyCells(List<String?> board) => [
        for (int i = 0; i < 9; i++)
          if (board[i] == null) i,
      ];

  String? _checkWinner(List<String?> board) {
    for (final p in _winPatterns) {
      if (board[p[0]] != null &&
          board[p[0]] == board[p[1]] &&
          board[p[1]] == board[p[2]]) {
        return board[p[0]];
      }
    }
    return null;
  }
}
