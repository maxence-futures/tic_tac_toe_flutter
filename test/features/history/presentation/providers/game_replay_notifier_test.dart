import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/game_move.dart';
import 'package:tic_tac_toe_flutter/features/history/presentation/providers/game_replay_notifier.dart';

void main() {
  final moves = List.generate(
    5,
    (i) => GameMove(
      position: i,
      symbol: i.isEven ? 'X' : 'O',
      isCpu: i.isOdd,
      timestamp: DateTime(2025, 1, 1, 0, 0, i),
    ),
  );

  group('GameReplayNotifier.boardAt', () {
    test('returns empty board at step 0', () {
      final board = GameReplayNotifier.boardAt(moves, 0);
      expect(board, everyElement(isNull));
    });

    test('applies one move at step 1', () {
      final board = GameReplayNotifier.boardAt(moves, 1);
      expect(board[0], 'X');
      expect(board[1], isNull);
    });

    test('applies all moves at step == moves.length', () {
      final board = GameReplayNotifier.boardAt(moves, moves.length);
      for (int i = 0; i < moves.length; i++) {
        expect(board[moves[i].position], moves[i].symbol);
      }
    });

    test('clamps step beyond moves.length', () {
      final boardFull = GameReplayNotifier.boardAt(moves, moves.length);
      final boardClamped = GameReplayNotifier.boardAt(moves, moves.length + 99);
      expect(boardFull, boardClamped);
    });

    test('correct symbol assignment at each step', () {
      for (int step = 0; step <= moves.length; step++) {
        final board = GameReplayNotifier.boardAt(moves, step);
        for (int i = 0; i < step; i++) {
          expect(board[moves[i].position], moves[i].symbol);
        }
      }
    });
  });
}
