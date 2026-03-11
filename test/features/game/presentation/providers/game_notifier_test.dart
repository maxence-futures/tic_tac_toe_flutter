// ignore_for_file: invalid_use_of_protected_member

import 'package:dartz/dartz.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/difficulty.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/game_move.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/game_status.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/repositories/game_repository.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/usecases/save_game_usecase.dart';
import 'package:tic_tac_toe_flutter/features/game/presentation/providers/game_notifier.dart';

/// Manual fake — avoids Mockito code-gen while keeping the test self-contained.
class _FakeGameRepository implements GameRepository {
  final List<String> savedResults = [];

  @override
  Future<Either<Exception, Unit>> saveGame({
    required String playerName,
    required Difficulty difficulty,
    required String result,
    required List<GameMove> moves,
    required DateTime playedAt,
  }) async {
    savedResults.add(result);
    return const Right(unit);
  }
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

GameState _initialWith({
  List<String?> board = const [
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
  ],
  String currentSymbol = 'X',
  Difficulty difficulty = Difficulty.hard,
  String playerName = 'Alice',
  bool isCpuThinking = false,
  GameStatus gameStatus = const GameStatus.playing(),
}) =>
    GameState.initial(playerName: playerName, difficulty: difficulty).copyWith(
      board: List<String?>.from(board),
      currentSymbol: currentSymbol,
      isCpuThinking: isCpuThinking,
      gameStatus: gameStatus,
    );

// ---------------------------------------------------------------------------

void main() {
  late _FakeGameRepository fakeRepo;
  late ProviderContainer container;

  setUp(() {
    fakeRepo = _FakeGameRepository();
    container = ProviderContainer(
      overrides: [
        saveGameUsecaseProvider.overrideWithValue(SaveGameUsecase(fakeRepo)),
      ],
    );
  });

  tearDown(() => container.dispose());

  // ---------------------------------------------------------------------------
  // build
  // ---------------------------------------------------------------------------

  group('GameNotifier.build', () {
    test(
      'initial state has empty board, playing status and correct metadata',
      () {
        final state = container.read(gameProvider('Alice', Difficulty.hard));

        expect(state.board, everyElement(isNull));
        expect(state.gameStatus, isA<GameStatusPlaying>());
        expect(state.currentSymbol, 'X');
        expect(state.moves, isEmpty);
        expect(state.playerName, 'Alice');
        expect(state.difficulty, Difficulty.hard);
        expect(state.isCpuThinking, isFalse);
      },
    );
  });

  // ---------------------------------------------------------------------------
  // makeMove — guards
  // ---------------------------------------------------------------------------

  group('GameNotifier.makeMove — guards', () {
    test('ignores tap on an occupied cell', () async {
      final notifier = container.read(
        gameProvider('Alice', Difficulty.hard).notifier,
      );
      notifier.state = _initialWith(
        board: ['X', null, null, null, null, null, null, null, null],
      );
      final before = container.read(gameProvider('Alice', Difficulty.hard));
      await notifier.makeMove(0); // cell 0 already occupied
      expect(
        container.read(gameProvider('Alice', Difficulty.hard)),
        same(before),
      );
    });

    test('ignores tap while CPU is thinking', () async {
      final notifier = container.read(
        gameProvider('Alice', Difficulty.hard).notifier,
      );
      notifier.state = _initialWith(isCpuThinking: true);
      final before = container.read(gameProvider('Alice', Difficulty.hard));
      await notifier.makeMove(0);
      expect(
        container.read(gameProvider('Alice', Difficulty.hard)),
        same(before),
      );
    });

    test('ignores tap when game is already won', () async {
      final notifier = container.read(
        gameProvider('Alice', Difficulty.hard).notifier,
      );
      notifier.state = _initialWith(
        gameStatus: const GameStatus.won(winner: 'X'),
      );
      final before = container.read(gameProvider('Alice', Difficulty.hard));
      await notifier.makeMove(0);
      expect(
        container.read(gameProvider('Alice', Difficulty.hard)),
        same(before),
      );
    });

    test('ignores tap when game is a draw', () async {
      final notifier = container.read(
        gameProvider('Alice', Difficulty.hard).notifier,
      );
      notifier.state = _initialWith(gameStatus: const GameStatus.draw());
      final before = container.read(gameProvider('Alice', Difficulty.hard));
      await notifier.makeMove(0);
      expect(
        container.read(gameProvider('Alice', Difficulty.hard)),
        same(before),
      );
    });
  });

  // ---------------------------------------------------------------------------
  // makeMove — player wins
  //
  // Board: X at {0,1}, O at {3,4}.
  // X plays 2  →  row {0,1,2}  →  X wins immediately, no CPU move.
  // ---------------------------------------------------------------------------

  group('GameNotifier.makeMove — player wins', () {
    const boardBeforeWin = ['X', 'X', null, 'O', 'O', null, null, null, null];

    GameNotifier notifier() =>
        container.read(gameProvider('Alice', Difficulty.hard).notifier);

    void setupBoard() => notifier().state = _initialWith(
      board: List<String?>.from(boardBeforeWin),
    );

    test('status transitions to won(X)', () async {
      setupBoard();
      await notifier().makeMove(2);
      final state = container.read(gameProvider('Alice', Difficulty.hard));
      expect(state.gameStatus, isA<GameStatusWon>());
      expect((state.gameStatus as GameStatusWon).winner, 'X');
    });

    test('winning positions contain {0, 1, 2}', () async {
      setupBoard();
      await notifier().makeMove(2);
      final state = container.read(gameProvider('Alice', Difficulty.hard));
      expect(state.winningPositions, containsAll([0, 1, 2]));
    });

    test('persists with "win" result', () async {
      setupBoard();
      await notifier().makeMove(2);
      expect(fakeRepo.savedResults, ['win']);
    });

    test('CPU does not move after player win', () async {
      setupBoard();
      await notifier().makeMove(2);
      final state = container.read(gameProvider('Alice', Difficulty.hard));
      // 4 pre-existing cells + 1 player move = 5; CPU never played.
      expect(state.board.where((c) => c != null).length, 5);
      expect(state.isCpuThinking, isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // makeMove — draw
  //
  // Board: X at {0,2,3,7}, O at {1,4,5,6}. X plays 8, board full, no winner.
  //
  // Row {0,1,2}=X,O,X  {3,4,5}=X,O,O  {6,7,8}=O,X,X  → none
  // Col {0,3,6}=X,X,O  {1,4,7}=O,O,X  {2,5,8}=X,O,X  → none
  // Diag {0,4,8}=X,O,X  {2,4,6}=X,O,O                → none → draw ✓
  // ---------------------------------------------------------------------------

  group('GameNotifier.makeMove — draw', () {
    const boardBeforeDraw = ['X', 'O', 'X', 'X', 'O', 'O', 'O', 'X', null];

    setUp(() {
      container
          .read(gameProvider('Alice', Difficulty.easy).notifier)
          .state = _initialWith(
        board: List<String?>.from(boardBeforeDraw),
        difficulty: Difficulty.easy,
      );
    });

    test('status transitions to draw', () async {
      await container
          .read(gameProvider('Alice', Difficulty.easy).notifier)
          .makeMove(8);
      final state = container.read(gameProvider('Alice', Difficulty.easy));
      expect(state.gameStatus, isA<GameStatusDraw>());
    });

    test('persists with "draw" result', () async {
      await container
          .read(gameProvider('Alice', Difficulty.easy).notifier)
          .makeMove(8);
      expect(fakeRepo.savedResults, ['draw']);
    });
  });

  // ---------------------------------------------------------------------------
  // makeMove — game continues (CPU plays)
  // ---------------------------------------------------------------------------

  group('GameNotifier.makeMove — game continues (CPU plays)', () {
    test('isCpuThinking is true during delay then false after', () {
      fakeAsync((async) {
        // A listener is required to keep the AutoDispose provider alive
        // across the async gap introduced by Future.delayed.
        final sub = container.listen(
          gameProvider('Alice', Difficulty.hard),
          (_, __) {},
        );
        final notifier = container.read(
          gameProvider('Alice', Difficulty.hard).notifier,
        );
        notifier.makeMove(4); // center cell; game continues
        expect(
          container.read(gameProvider('Alice', Difficulty.hard)).isCpuThinking,
          isTrue,
        );
        async.elapse(const Duration(seconds: 1));
        expect(
          container.read(gameProvider('Alice', Difficulty.hard)).isCpuThinking,
          isFalse,
        );
        sub.close();
      });
    });

    test('CPU places exactly one move after the delay', () {
      fakeAsync((async) {
        final sub = container.listen(
          gameProvider('Alice', Difficulty.hard),
          (_, __) {},
        );
        container
            .read(gameProvider('Alice', Difficulty.hard).notifier)
            .makeMove(4);
        async.elapse(const Duration(seconds: 1));
        final state = container.read(gameProvider('Alice', Difficulty.hard));
        // X at 4, O somewhere → 2 total pieces on the board.
        expect(state.board.where((c) => c != null).length, 2);
        expect(state.moves.length, 2);
        expect(state.moves.last.isCpu, isTrue);
        sub.close();
      });
    });

    test('saveGame is not called while game is ongoing', () {
      fakeAsync((async) {
        final sub = container.listen(
          gameProvider('Alice', Difficulty.hard),
          (_, __) {},
        );
        container
            .read(gameProvider('Alice', Difficulty.hard).notifier)
            .makeMove(4);
        async.elapse(const Duration(seconds: 1));
        expect(fakeRepo.savedResults, isEmpty);
        sub.close();
      });
    });
  });

  // ---------------------------------------------------------------------------
  // makeMove — CPU wins
  //
  // Board: X at {0}, O at {3,4}. X plays 6 → X at {0,6}, no win.
  // Minimax (hard): O plays 5 → row {3,4,5} → O wins.
  //
  // X threats: col {0,3,6} blocked (O at 3), no immediate threat.
  // O threat: plays 5 for immediate win (score 10) → minimax picks 5. ✓
  // ---------------------------------------------------------------------------

  group('GameNotifier.makeMove — CPU wins', () {
    const boardBeforeCpuWin = [
      'X',
      null,
      null,
      'O',
      'O',
      null,
      null,
      null,
      null,
    ];

    test('status transitions to won(O)', () {
      fakeAsync((async) {
        final sub = container.listen(
          gameProvider('Alice', Difficulty.hard),
          (_, __) {},
        );
        final notifier = container.read(
          gameProvider('Alice', Difficulty.hard).notifier,
        );
        notifier.state = _initialWith(
          board: List<String?>.from(boardBeforeCpuWin),
        );
        notifier.makeMove(6); // X plays 6, no win
        async.elapse(const Duration(seconds: 1));
        final state = container.read(gameProvider('Alice', Difficulty.hard));
        expect(state.gameStatus, isA<GameStatusWon>());
        expect((state.gameStatus as GameStatusWon).winner, 'O');
        sub.close();
      });
    });

    test('persists with "loss" result', () {
      fakeAsync((async) {
        final sub = container.listen(
          gameProvider('Alice', Difficulty.hard),
          (_, __) {},
        );
        final notifier = container.read(
          gameProvider('Alice', Difficulty.hard).notifier,
        );
        notifier.state = _initialWith(
          board: List<String?>.from(boardBeforeCpuWin),
        );
        notifier.makeMove(6);
        async.elapse(const Duration(seconds: 1));
        async.flushMicrotasks();
        expect(fakeRepo.savedResults, ['loss']);
        sub.close();
      });
    });
  });

  // ---------------------------------------------------------------------------
  // resetGame
  // ---------------------------------------------------------------------------

  group('GameNotifier.resetGame', () {
    test('board becomes empty and status resets to playing', () {
      final notifier = container.read(
        gameProvider('Alice', Difficulty.hard).notifier,
      );
      notifier.state = _initialWith(
        board: ['X', null, null, null, null, null, null, null, null],
      );
      notifier.resetGame();
      final state = container.read(gameProvider('Alice', Difficulty.hard));
      expect(state.board, everyElement(isNull));
      expect(state.gameStatus, isA<GameStatusPlaying>());
      expect(state.currentSymbol, 'X');
      expect(state.isCpuThinking, isFalse);
    });

    test('moves list is cleared after reset', () {
      final notifier = container.read(
        gameProvider('Alice', Difficulty.hard).notifier,
      );
      notifier.state = _initialWith(
        board: ['X', null, null, null, null, null, null, null, null],
      );
      notifier.resetGame();
      expect(
        container.read(gameProvider('Alice', Difficulty.hard)).moves,
        isEmpty,
      );
    });

    test('playerName and difficulty are preserved after reset', () {
      final notifier = container.read(
        gameProvider('Alice', Difficulty.hard).notifier,
      );
      notifier.resetGame();
      final state = container.read(gameProvider('Alice', Difficulty.hard));
      expect(state.playerName, 'Alice');
      expect(state.difficulty, Difficulty.hard);
    });
  });
}
