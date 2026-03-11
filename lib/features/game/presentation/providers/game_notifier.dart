import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tic_tac_toe_flutter/core/database/app_database.dart';
import 'package:tic_tac_toe_flutter/core/ui/theme/app_durations.dart';
import 'package:tic_tac_toe_flutter/features/game/data/repositories/game_repository_impl.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/difficulty.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/game_status.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/repositories/game_repository.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/usecases/get_cpu_move_usecase.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/usecases/save_game_usecase.dart';

part 'game_notifier.g.dart';

@Riverpod(keepAlive: false)
GameRepository gameRepository(Ref ref) {
  return GameRepositoryImpl(ref.watch(appDatabaseProvider));
}

@Riverpod(keepAlive: false)
GetCpuMoveUsecase getCpuMoveUsecase(Ref ref) {
  return const GetCpuMoveUsecase();
}

@Riverpod(keepAlive: false)
SaveGameUsecase saveGameUsecase(Ref ref) {
  return SaveGameUsecase(ref.watch(gameRepositoryProvider));
}

@riverpod
class GameNotifier extends _$GameNotifier {
  @override
  GameState build(String playerName, Difficulty difficulty) {
    return GameState.initial(playerName: playerName, difficulty: difficulty);
  }

  // ---------------------------------------------------------------------------
  // Public actions
  // ---------------------------------------------------------------------------

  Future<void> makeMove(int position) async {
    // Ignore taps during CPU turn, on occupied cells, or when the game is over.
    if (!state.canPlayerMove(position)) return;

    // --- Player move ---
    final playerCheck = state.withMove(position, 'X', isCpu: false).evaluate();
    state = playerCheck;

    // Player wins or board is full — persist and stop before triggering CPU.
    if (playerCheck.gameStatus is! GameStatusPlaying) {
      await _persistGame(playerCheck);
      return;
    }

    // --- CPU move ---
    // Show a thinking indicator for a human-perceivable delay.
    state = playerCheck.copyWith(isCpuThinking: true, currentSymbol: 'O');
    await Future<void>.delayed(AppDurations().cpuThinking);

    // -1 means no move is available (full board edge case already caught above).
    final cpuPos = ref.read(getCpuMoveUsecaseProvider)(
      board: state.board,
      difficulty: state.difficulty,
    );
    if (cpuPos == -1) return;

    final cpuCheck = state
        .withMove(cpuPos, 'O', isCpu: true)
        .evaluate()
        .copyWith(isCpuThinking: false, currentSymbol: 'X');
    state = cpuCheck;

    if (cpuCheck.gameStatus is! GameStatusPlaying) {
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

  Future<void> _persistGame(GameState s) async {
    await ref.read(saveGameUsecaseProvider)(s);
  }
}
