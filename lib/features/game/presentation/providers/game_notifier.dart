import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/app_database.dart';
import '../../data/repositories/game_repository_impl.dart';
import '../../domain/entities/difficulty.dart';
import '../../domain/entities/game_move.dart';
import '../../domain/entities/game_state.dart';
import '../../domain/entities/game_status.dart';
import '../../domain/repositories/game_repository.dart';
import '../../domain/usecases/get_cpu_move_usecase.dart';
import '../../domain/usecases/save_game_usecase.dart';

part 'game_notifier.g.dart';

@Riverpod(keepAlive: false)
GameRepository gameRepository(Ref ref) {
  return GameRepositoryImpl(ref.watch(appDatabaseProvider));
}

@riverpod
class GameNotifier extends _$GameNotifier {
  static const _winPatterns = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  late final GetCpuMoveUsecase _getCpuMove;
  late final SaveGameUsecase _saveGame;

  @override
  GameState build(String playerName, Difficulty difficulty) {
    _getCpuMove = const GetCpuMoveUsecase();
    _saveGame = SaveGameUsecase(ref.read(gameRepositoryProvider));
    return GameState.initial(playerName: playerName, difficulty: difficulty);
  }

  // ---------------------------------------------------------------------------
  // Public actions
  // ---------------------------------------------------------------------------

  Future<void> makeMove(int position) async {
    if (!_canMove(position)) return;

    final afterPlayer = _applyMove(state, position, 'X', isCpu: false);
    final playerCheck = _evaluate(afterPlayer);
    state = playerCheck;

    if (playerCheck.status is! GameStatusPlaying) {
      await _persistGame(playerCheck);
      return;
    }

    state = playerCheck.copyWith(isCpuThinking: true, currentSymbol: 'O');
    await Future<void>.delayed(const Duration(milliseconds: 750));

    final cpuPos = _getCpuMove(state.board, state.difficulty);
    if (cpuPos == -1) return;

    final afterCpu = _applyMove(state, cpuPos, 'O', isCpu: true);
    final cpuCheck = _evaluate(
      afterCpu,
    ).copyWith(isCpuThinking: false, currentSymbol: 'X');
    state = cpuCheck;

    if (cpuCheck.status is! GameStatusPlaying) {
      await _persistGame(cpuCheck);
    }
  }

  void resetGame() {
    state = GameState.initial(
      playerName: state.playerName,
      difficulty: state.difficulty,
    );
  }

  // ---------------------------------------------------------------------------
  // Internal helpers
  // ---------------------------------------------------------------------------

  bool _canMove(int position) =>
      state.status is GameStatusPlaying &&
      !state.isCpuThinking &&
      state.board[position] == null &&
      state.currentSymbol == 'X';

  GameState _applyMove(
    GameState s,
    int pos,
    String symbol, {
    required bool isCpu,
  }) {
    final board = List<String?>.from(s.board)..[pos] = symbol;
    final move = GameMove(
      position: pos,
      symbol: symbol,
      isCpu: isCpu,
      timestamp: DateTime.now(),
    );
    return s.copyWith(board: board, moves: [...s.moves, move]);
  }

  GameState _evaluate(GameState s) {
    for (final p in _winPatterns) {
      if (s.board[p[0]] != null &&
          s.board[p[0]] == s.board[p[1]] &&
          s.board[p[1]] == s.board[p[2]]) {
        return s.copyWith(
          status: GameStatus.won(winner: s.board[p[0]]!),
          winningPositions: p,
        );
      }
    }
    if (!s.board.contains(null)) {
      return s.copyWith(status: const GameStatus.draw());
    }
    return s;
  }

  Future<void> _persistGame(GameState s) async {
    await _saveGame(s);
  }
}
