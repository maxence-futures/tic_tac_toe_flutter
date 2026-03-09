import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/difficulty.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/usecases/get_cpu_move_usecase.dart';

void main() {
  late GetCpuMoveUsecase usecase;

  setUp(() => usecase = const GetCpuMoveUsecase());

  /// Builds a board from a 9-char string: 'X', 'O', or '_' (empty).
  List<String?> b(String s) =>
      s.split('').map((c) => c == '_' ? null : c).toList();

  // ---------------------------------------------------------------------------
  // Easy
  // ---------------------------------------------------------------------------

  group('easy', () {
    test('returns a valid index on an empty board', () {
      final pos = usecase(b('_________'), Difficulty.easy);
      expect(pos, inInclusiveRange(0, 8));
    });

    test('returns -1 on a full board', () {
      expect(usecase(b('XOXOXOXOX'), Difficulty.easy), -1);
    });

    test('always picks an empty cell', () {
      final board = b('XO_X_O__X');
      for (var i = 0; i < 20; i++) {
        expect(board[usecase(board, Difficulty.easy)], isNull);
      }
    });
  });

  // ---------------------------------------------------------------------------
  // Hard — minimax
  // ---------------------------------------------------------------------------

  group('hard — wins immediately when possible', () {
    test('takes the winning move in row 0 (O at 3 and 4, wins at 5)', () {
      // O O _ : positions 3-4-5 → CPU must complete row 1 at pos 5
      //   Board: X X _ O O _ _ _ _
      expect(usecase(b('XX_OO____'), Difficulty.hard), 5);
    });

    test('takes the winning diagonal (O at 2 and 4, wins at 6)', () {
      // diagonal: 2-4-6 → O can win at 6
      //   Board: _ X O X O _ _ _ _
      expect(usecase(b('_XOXO____'), Difficulty.hard), 6);
    });
  });

  group('hard — blocks player when no immediate win', () {
    test('blocks X winning in row 0 (X at 0 and 1, O only at 4)', () {
      // X X _ O _ _ _ _ _ → O must block position 2
      //   CPU has no winning move, must block
      expect(usecase(b('XX_O_____'), Difficulty.hard), 2);
    });

    test('blocks X winning in column (X at 0 and 3, empty at 6)', () {
      // col 0: 0-3-6 → X can win at 6; O at 2 has no winning threat
      // Board: X _ O X _ _ _ _ _
      expect(usecase(b('X_OX_____'), Difficulty.hard), 6);
    });
  });

  group('hard — general minimax properties', () {
    test('always picks an empty cell', () {
      final board = b('XO_X_O__X');
      expect(board[usecase(board, Difficulty.hard)], isNull);
    });

    test('returns -1 on a full board', () {
      expect(usecase(b('XOXOXOXOX'), Difficulty.hard), -1);
    });
  });

  // ---------------------------------------------------------------------------
  // Medium
  // ---------------------------------------------------------------------------

  group('medium', () {
    test('always picks an empty cell', () {
      final board = b('XO_X_O__X');
      for (var i = 0; i < 30; i++) {
        expect(board[usecase(board, Difficulty.medium)], isNull);
      }
    });

    test('returns -1 on a full board', () {
      expect(usecase(b('XOXOXOXOX'), Difficulty.medium), -1);
    });
  });
}
