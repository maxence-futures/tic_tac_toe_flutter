import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/difficulty.dart';
import 'package:tic_tac_toe_flutter/features/history/domain/entities/game_record.dart';
import 'package:tic_tac_toe_flutter/features/history/domain/repositories/history_repository.dart';
import 'package:tic_tac_toe_flutter/features/history/domain/usecases/get_game_history_usecase.dart';

// Minimal in-memory stub — no third-party mock library needed.
final class _FakeHistoryRepository implements HistoryRepository {
  _FakeHistoryRepository(this._records);

  final Either<Exception, List<GameRecord>> _records;

  @override
  Future<Either<Exception, List<GameRecord>>> getHistory() async => _records;

  @override
  Future<Either<Exception, Unit>> deleteGame(int id) async => const Right(unit);
}

void main() {
  final sampleRecord = GameRecord(
    id: 1,
    playerName: 'Alice',
    difficulty: Difficulty.hard,
    result: 'win',
    moves: const [],
    playedAt: DateTime(2025, 1, 1),
  );

  group('GetGameHistoryUsecase', () {
    test('returns list on success', () async {
      final usecase = GetGameHistoryUsecase(
        _FakeHistoryRepository(Right([sampleRecord])),
      );

      final result = await usecase();

      expect(result.isRight(), isTrue);
      result.fold((_) => fail('Expected Right'), (records) {
        expect(records.length, 1);
        expect(records.first.playerName, 'Alice');
      });
    });

    test('propagates exception on failure', () async {
      final exception = Exception('DB error');
      final usecase = GetGameHistoryUsecase(
        _FakeHistoryRepository(Left(exception)),
      );

      final result = await usecase();

      expect(result.isLeft(), isTrue);
    });

    test('returns empty list when history is empty', () async {
      final usecase = GetGameHistoryUsecase(
        _FakeHistoryRepository(const Right([])),
      );

      final result = await usecase();

      result.fold(
        (_) => fail('Expected Right'),
        (records) => expect(records, isEmpty),
      );
    });
  });
}
