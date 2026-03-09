import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../game/domain/entities/game_move.dart';

part 'game_replay_notifier.g.dart';

/// Tracks the current replay step (0 = empty board, N = after N moves).
@riverpod
class GameReplayNotifier extends _$GameReplayNotifier {
  @override
  int build(int recordId) => 0;

  void stepForward(int maxStep) {
    if (state < maxStep) state++;
  }

  void stepBack() {
    if (state > 0) state--;
  }

  void jumpTo(int step) => state = step;

  /// Reconstructs the board at [step] from a list of [moves].
  static List<String?> boardAt(List<GameMove> moves, int step) {
    final board = List<String?>.filled(9, null);
    for (var i = 0; i < step.clamp(0, moves.length); i++) {
      board[moves[i].position] = moves[i].symbol;
    }
    return board;
  }
}
