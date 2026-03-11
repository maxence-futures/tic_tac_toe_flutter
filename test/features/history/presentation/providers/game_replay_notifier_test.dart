import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/game_move.dart';
import 'package:tic_tac_toe_flutter/features/history/presentation/providers/game_replay_notifier.dart';

void main() {
  late ProviderContainer container;
  late GameReplayNotifier notifier;

  final moves = List.generate(
    5,
    (i) => GameMove(
      position: i,
      symbol: i.isEven ? 'X' : 'O',
      isCpu: i.isOdd,
      timestamp: DateTime(2025, 1, 1, 0, 0, i),
    ),
  );

  setUp(() {
    container = ProviderContainer();
    notifier = container.read(gameReplayProvider(0).notifier);
  });

  tearDown(() => container.dispose());

  group('GameReplayNotifier.boardAt', () {
    test('returns empty board at step 0', () {
      final board = notifier.boardAt(moves, 0);
      expect(board, everyElement(isNull));
    });

    test('applies one move at step 1', () {
      final board = notifier.boardAt(moves, 1);
      expect(board[0], 'X');
      expect(board[1], isNull);
    });

    test('applies all moves at step == moves.length', () {
      final board = notifier.boardAt(moves, moves.length);
      for (int i = 0; i < moves.length; i++) {
        expect(board[moves[i].position], moves[i].symbol);
      }
    });

    test('clamps step beyond moves.length', () {
      final boardFull = notifier.boardAt(moves, moves.length);
      final boardClamped = notifier.boardAt(moves, moves.length + 99);
      expect(boardFull, boardClamped);
    });

    test('correct symbol assignment at each step', () {
      for (int step = 0; step <= moves.length; step++) {
        final board = notifier.boardAt(moves, step);
        for (int i = 0; i < step; i++) {
          expect(board[moves[i].position], moves[i].symbol);
        }
      }
    });
  });

  group('GameReplayNotifier.winningPositionsAt', () {
    GameMove m(int pos, String sym) => GameMove(
      position: pos,
      symbol: sym,
      isCpu: sym == 'O',
      timestamp: DateTime(2025),
    );

    // X wins on row [0,1,2]
    final rowWinMoves = [m(0, 'X'), m(3, 'O'), m(1, 'X'), m(4, 'O'), m(2, 'X')];

    // O wins on column [0,3,6]
    final colWinMoves = [
      m(1, 'X'),
      m(0, 'O'),
      m(2, 'X'),
      m(3, 'O'),
      m(4, 'X'),
      m(6, 'O'),
    ];

    // X wins on diagonal [0,4,8]
    final diagWinMoves = [
      m(0, 'X'),
      m(1, 'O'),
      m(4, 'X'),
      m(2, 'O'),
      m(8, 'X'),
    ];

    // Full board draw:
    // X | O | X
    // O | O | X
    // X | X | O  → no winning line
    final drawMoves = [
      m(0, 'X'),
      m(1, 'O'),
      m(2, 'X'),
      m(3, 'O'),
      m(5, 'X'),
      m(4, 'O'),
      m(6, 'X'),
      m(8, 'O'),
      m(7, 'X'),
    ];

    test('returns empty before any winning move', () {
      expect(notifier.winningPositionsAt(rowWinMoves, 4), isEmpty);
    });

    test('returns empty for an empty board', () {
      expect(notifier.winningPositionsAt(rowWinMoves, 0), isEmpty);
    });

    test('X wins on row [0,1,2]', () {
      expect(
        notifier.winningPositionsAt(rowWinMoves, 5),
        containsAll([0, 1, 2]),
      );
    });

    test('O wins on column [0,3,6]', () {
      expect(
        notifier.winningPositionsAt(colWinMoves, colWinMoves.length),
        containsAll([0, 3, 6]),
      );
    });

    test('X wins on diagonal [0,4,8]', () {
      expect(
        notifier.winningPositionsAt(diagWinMoves, diagWinMoves.length),
        containsAll([0, 4, 8]),
      );
    });

    test('returns empty on a full draw board', () {
      expect(notifier.winningPositionsAt(drawMoves, drawMoves.length), isEmpty);
    });
  });

  group('GameReplayNotifier navigation', () {
    test('initial state is 0', () {
      expect(container.read(gameReplayProvider(0)), 0);
    });

    test('stepForward increments state', () {
      notifier.stepForward(5);
      expect(container.read(gameReplayProvider(0)), 1);
    });

    test('stepForward does not exceed maxStep', () {
      notifier.jumpTo(5);
      notifier.stepForward(5);
      expect(container.read(gameReplayProvider(0)), 5);
    });

    test('stepBack decrements state', () {
      notifier.jumpTo(3);
      notifier.stepBack();
      expect(container.read(gameReplayProvider(0)), 2);
    });

    test('stepBack does not go below 0', () {
      notifier.stepBack();
      expect(container.read(gameReplayProvider(0)), 0);
    });

    test('jumpTo sets state to given step', () {
      notifier.jumpTo(4);
      expect(container.read(gameReplayProvider(0)), 4);
    });
  });
}
