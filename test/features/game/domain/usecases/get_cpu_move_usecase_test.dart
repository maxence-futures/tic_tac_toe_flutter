import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_flutter/core/domain/game_rules/board_rules.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/difficulty.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/usecases/get_cpu_move_usecase.dart';

void main() {
  late GetCpuMoveUsecase getCpuMoveUseCase;

  setUp(() => getCpuMoveUseCase = const GetCpuMoveUsecase());

  /// Builds a board from a 9-char string: 'X', 'O', or '_' (empty).
  List<String?> boardTest(String s) =>
      s.split('').map((c) => c == '_' ? null : c).toList();

  // ---------------------------------------------------------------------------
  // Easy
  // ---------------------------------------------------------------------------

  group('easy', () {
    test('returns a valid index on an empty board', () {
      final pos = getCpuMoveUseCase(
        board: boardTest('_________'),
        difficulty: Difficulty.easy,
      );
      expect(pos, inInclusiveRange(0, 8));
    });

    test('returns -1 on a full board', () {
      expect(
        getCpuMoveUseCase(
          board: boardTest('XOXOXOXOX'),
          difficulty: Difficulty.easy,
        ),
        -1,
      );
    });

    test('always picks an empty cell', () {
      final board = boardTest('XO_X_O__X');
      for (var i = 0; i < 20; i++) {
        expect(
          board[getCpuMoveUseCase(board: board, difficulty: Difficulty.easy)],
          isNull,
        );
      }
    });

    test('returns the only available cell', () {
      // One empty cell at index 5 — must return it regardless of difficulty.
      expect(
        getCpuMoveUseCase(
          board: boardTest('XOXOX_OXO'),
          difficulty: Difficulty.easy,
        ),
        5,
      );
    });
  });

  // ---------------------------------------------------------------------------
  // Hard — minimax
  // ---------------------------------------------------------------------------

  group('hard — wins immediately when possible', () {
    test('completes a row (O at 3 and 4, wins at 5)', () {
      // X X _ | O O _ | _ _ _   →   CPU must take 5
      expect(
        getCpuMoveUseCase(
          board: boardTest('XX_OO____'),
          difficulty: Difficulty.hard,
        ),
        5,
      );
    });

    test('completes a diagonal (O at 2 and 4, wins at 6)', () {
      // _ X O | X O _ | _ _ _   →   diagonal 2-4-6, CPU takes 6
      expect(
        getCpuMoveUseCase(
          board: boardTest('_XOXO____'),
          difficulty: Difficulty.hard,
        ),
        6,
      );
    });

    test('completes a column (O at 0 and 3, wins at 6)', () {
      // O _ X | O _ X | _ _ _   →   col 0, CPU takes 6
      expect(
        getCpuMoveUseCase(
          board: boardTest('O_XO_X___'),
          difficulty: Difficulty.hard,
        ),
        6,
      );
    });

    test(
      'prefers immediate win over blocking (O wins at 5, X threatens at 2)',
      () {
        // O O _ | X X _ | _ _ _   →   CPU wins at 5, must not waste turn blocking
        expect(
          getCpuMoveUseCase(
            board: boardTest('OO_XX____'),
            difficulty: Difficulty.hard,
          ),
          2,
        );
      },
    );
  });

  group('hard — blocks player when no immediate win', () {
    test('blocks X winning in a row (X at 0 and 1, O only at 4)', () {
      // X X _ | _ O _ | _ _ _   →   CPU blocks at 2
      expect(
        getCpuMoveUseCase(
          board: boardTest('XX_O_____'),
          difficulty: Difficulty.hard,
        ),
        2,
      );
    });

    test('blocks X winning in a column (X at 0 and 3, empty at 6)', () {
      // X _ O | X _ _ | _ _ _   →   col 0, CPU blocks at 6
      expect(
        getCpuMoveUseCase(
          board: boardTest('X_OX_____'),
          difficulty: Difficulty.hard,
        ),
        6,
      );
    });

    test('blocks X winning on a diagonal (X at 0 and 8, O at 6)', () {
      // X _ _ | _ _ _ | O _ X   →   diagonal 0-4-8, CPU blocks at 4
      expect(
        getCpuMoveUseCase(
          board: boardTest('X_____O_X'),
          difficulty: Difficulty.hard,
        ),
        4,
      );
    });
  });

  group('hard — general minimax properties', () {
    test('always picks an empty cell', () {
      final board = boardTest('XO_X_O__X');
      expect(
        board[getCpuMoveUseCase(board: board, difficulty: Difficulty.hard)],
        isNull,
      );
    });

    test('returns -1 on a full board', () {
      expect(
        getCpuMoveUseCase(
          board: boardTest('XOXOXOXOX'),
          difficulty: Difficulty.hard,
        ),
        -1,
      );
    });

    test('returns the only available cell', () {
      expect(
        getCpuMoveUseCase(
          board: boardTest('XOXOX_OXO'),
          difficulty: Difficulty.hard,
        ),
        5,
      );
    });

    test('never loses against a random opponent (100 simulated games)', () {
      // X plays random, O plays minimax — O must never lose.
      final random = Random(42);

      for (var game = 0; game < 100; game++) {
        final board = List<String?>.filled(9, null);

        while (true) {
          // X plays randomly.
          final xMoves = [
            for (var i = 0; i < 9; i++)
              if (board[i] == null) i,
          ];
          if (xMoves.isEmpty) break;
          board[xMoves[random.nextInt(xMoves.length)]] = 'X';
          if (BoardRules.findWinningLine(board) != null ||
              !board.contains(null)) {
            break;
          }

          // O plays minimax.
          final oPos = getCpuMoveUseCase(
            board: board,
            difficulty: Difficulty.hard,
          );
          if (oPos == -1) break;
          board[oPos] = 'O';
          if (BoardRules.findWinningLine(board) != null ||
              !board.contains(null)) {
            break;
          }
        }

        final line = BoardRules.findWinningLine(board);
        final winner = line != null ? board[line[0]] : null;
        expect(
          winner,
          isNot('X'),
          reason: 'CPU should never lose (game $game)',
        );
      }
    });
  });

  // ---------------------------------------------------------------------------
  // Medium
  // ---------------------------------------------------------------------------

  group('medium', () {
    test('always picks an empty cell', () {
      final board = boardTest('XO_X_O__X');
      for (var i = 0; i < 30; i++) {
        expect(
          board[getCpuMoveUseCase(board: board, difficulty: Difficulty.medium)],
          isNull,
        );
      }
    });

    test('returns -1 on a full board', () {
      expect(
        getCpuMoveUseCase(
          board: boardTest('XOXOXOXOX'),
          difficulty: Difficulty.medium,
        ),
        -1,
      );
    });

    test('returns the only available cell', () {
      expect(
        getCpuMoveUseCase(
          board: boardTest('XOXOX_OXO'),
          difficulty: Difficulty.medium,
        ),
        5,
      );
    });
  });
}
