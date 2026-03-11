import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/difficulty.dart';
import 'package:tic_tac_toe_flutter/features/history/domain/entities/game_record.dart';
import 'package:tic_tac_toe_flutter/features/history/domain/repositories/history_repository.dart';
import 'package:tic_tac_toe_flutter/features/history/domain/usecases/get_game_history_usecase.dart';

import 'get_game_history_usecase_test.mocks.dart';

@GenerateMocks([HistoryRepository])
void main() {
  late MockHistoryRepository mockRepo;

  final sampleRecord = GameRecord(
    id: 1,
    playerName: 'Alice',
    difficulty: Difficulty.hard,
    result: 'win',
    moves: const [],
    playedAt: DateTime(2025, 1, 1),
  );

  setUp(() {
    mockRepo = MockHistoryRepository();
  });

  group('GetGameHistoryUsecase', () {
    test('returns list on success', () async {
      when(
        mockRepo.getHistory(),
      ).thenAnswer((_) async => Right([sampleRecord]));

      final result = await GetGameHistoryUsecase(mockRepo)();

      expect(result.isRight(), isTrue);
      result.fold((_) => fail('Expected Right'), (records) {
        expect(records.length, 1);
        expect(records.first.playerName, 'Alice');
      });
      verify(mockRepo.getHistory()).called(1);
    });

    test('propagates exception on failure', () async {
      when(
        mockRepo.getHistory(),
      ).thenAnswer((_) async => Left(Exception('DB error')));

      final result = await GetGameHistoryUsecase(mockRepo)();

      expect(result.isLeft(), isTrue);
      verify(mockRepo.getHistory()).called(1);
    });

    test('returns empty list when history is empty', () async {
      when(mockRepo.getHistory()).thenAnswer((_) async => const Right([]));

      final result = await GetGameHistoryUsecase(mockRepo)();

      result.fold(
        (_) => fail('Expected Right'),
        (records) => expect(records, isEmpty),
      );
      verify(mockRepo.getHistory()).called(1);
    });
  });
}
