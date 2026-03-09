import 'package:dartz/dartz.dart';

import '../entities/game_state.dart';
import '../entities/game_status.dart';
import '../repositories/game_repository.dart';

final class SaveGameUsecase {
  const SaveGameUsecase(this._repository);

  final GameRepository _repository;

  Future<Either<Exception, Unit>> call(GameState state) {
    final result = switch (state.status) {
      GameStatusWon(:final winner) => winner == 'X' ? 'win' : 'loss',
      GameStatusDraw() => 'draw',
      GameStatusPlaying() => 'draw', // fallback — should not happen
      // TODO: Handle this case.
      GameStatus() => throw UnimplementedError(),
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
