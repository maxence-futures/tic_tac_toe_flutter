import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/difficulty.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/game_status.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/repositories/game_repository.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/usecases/save_game_usecase.dart';

import 'save_game_usecase_test.mocks.dart';

@GenerateMocks([GameRepository])
void main() {
  late MockGameRepository mockRepo;
  late SaveGameUsecase usecase;

  GameState stateWith(GameStatus status) => GameState.initial(
    playerName: 'Alice',
    difficulty: Difficulty.hard,
  ).copyWith(gameStatus: status);

  setUp(() {
    mockRepo = MockGameRepository();
    usecase = SaveGameUsecase(mockRepo);
    when(
      mockRepo.saveGame(
        playerName: anyNamed('playerName'),
        difficulty: anyNamed('difficulty'),
        result: anyNamed('result'),
        moves: anyNamed('moves'),
        playedAt: anyNamed('playedAt'),
      ),
    ).thenAnswer((_) async => const Right(unit));
  });

  group('SaveGameUsecase — result mapping', () {
    test('maps won(X) → "win"', () async {
      await usecase(stateWith(const GameStatus.won(winner: 'X')));

      verify(
        mockRepo.saveGame(
          playerName: anyNamed('playerName'),
          difficulty: anyNamed('difficulty'),
          result: 'win',
          moves: anyNamed('moves'),
          playedAt: anyNamed('playedAt'),
        ),
      ).called(1);
    });

    test('maps won(O) → "loss"', () async {
      await usecase(stateWith(const GameStatus.won(winner: 'O')));

      verify(
        mockRepo.saveGame(
          playerName: anyNamed('playerName'),
          difficulty: anyNamed('difficulty'),
          result: 'loss',
          moves: anyNamed('moves'),
          playedAt: anyNamed('playedAt'),
        ),
      ).called(1);
    });

    test('maps draw → "draw"', () async {
      await usecase(stateWith(const GameStatus.draw()));

      verify(
        mockRepo.saveGame(
          playerName: anyNamed('playerName'),
          difficulty: anyNamed('difficulty'),
          result: 'draw',
          moves: anyNamed('moves'),
          playedAt: anyNamed('playedAt'),
        ),
      ).called(1);
    });

    test('maps playing → "draw" (fallback)', () async {
      await usecase(stateWith(const GameStatus.playing()));

      verify(
        mockRepo.saveGame(
          playerName: anyNamed('playerName'),
          difficulty: anyNamed('difficulty'),
          result: 'draw',
          moves: anyNamed('moves'),
          playedAt: anyNamed('playedAt'),
        ),
      ).called(1);
    });
  });

  group('SaveGameUsecase — repository contract', () {
    test('passes playerName and difficulty from state', () async {
      await usecase(stateWith(const GameStatus.draw()));

      verify(
        mockRepo.saveGame(
          playerName: 'Alice',
          difficulty: Difficulty.hard,
          result: anyNamed('result'),
          moves: anyNamed('moves'),
          playedAt: anyNamed('playedAt'),
        ),
      ).called(1);
    });

    test('propagates Left when repository fails', () async {
      final exception = Exception('DB error');
      when(
        mockRepo.saveGame(
          playerName: anyNamed('playerName'),
          difficulty: anyNamed('difficulty'),
          result: anyNamed('result'),
          moves: anyNamed('moves'),
          playedAt: anyNamed('playedAt'),
        ),
      ).thenAnswer((_) async => Left(exception));

      final result = await usecase(
        stateWith(const GameStatus.won(winner: 'X')),
      );

      expect(result.isLeft(), isTrue);
    });
  });
}
