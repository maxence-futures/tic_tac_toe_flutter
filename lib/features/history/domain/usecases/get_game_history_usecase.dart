import 'package:dartz/dartz.dart';

import '../entities/game_record.dart';
import '../repositories/history_repository.dart';

final class GetGameHistoryUsecase {
  const GetGameHistoryUsecase(this._repository);

  final HistoryRepository _repository;

  Future<Either<Exception, List<GameRecord>>> call() =>
      _repository.getHistory();
}
