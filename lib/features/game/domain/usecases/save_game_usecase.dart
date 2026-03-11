import 'package:dartz/dartz.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/game_status.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/repositories/game_repository.dart';

final class SaveGameUsecase {
  const SaveGameUsecase(this._repository);

  final GameRepository _repository;

  Future<Either<Exception, Unit>> call(GameState state) {
    final result = switch (state.gameStatus) {
      GameStatusWon(:final winner) => winner == 'X' ? 'win' : 'loss',
      GameStatusDraw() => 'draw',
      GameStatusPlaying() => 'draw', // fallback — should not happen
    };

    return _repository.saveGame(
      playerName: state.playerName,
      difficulty: state.difficulty,
      result: result,
      moves: state.moves,
      playedAt: DateTime.now(),
    );
  }
}
