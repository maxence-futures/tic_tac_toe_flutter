/// Pure game rules for a 3×3 Tic-Tac-Toe board.
abstract final class BoardRules {
  /// All winning lines (rows, columns, diagonals).
  static const List<List<int>> winPatterns = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], // cols
    [0, 4, 8], [2, 4, 6],             // diagonals
  ];

  /// Returns the winning line `[a, b, c]` if [board] has a winner, otherwise null.
  static List<int>? findWinningLine(List<String?> board) {
    for (final p in winPatterns) {
      if (board[p[0]] != null &&
          board[p[0]] == board[p[1]] &&
          board[p[1]] == board[p[2]]) {
        return p;
      }
    }
    return null;
  }
}
