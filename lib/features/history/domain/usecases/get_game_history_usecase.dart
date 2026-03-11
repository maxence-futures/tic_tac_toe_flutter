import 'package:dartz/dartz.dart';

import 'package:tic_tac_toe_flutter/features/history/domain/entities/game_record.dart';
import 'package:tic_tac_toe_flutter/features/history/domain/repositories/history_repository.dart';

final class GetGameHistoryUsecase {
  const GetGameHistoryUsecase(this._repository);

  final HistoryRepository _repository;

  Future<Either<Exception, List<GameRecord>>> call() =>
      _repository.getHistory();
}
