import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tic_tac_toe_flutter/core/database/app_database.dart';
import 'package:tic_tac_toe_flutter/core/services/providers/services_providers.dart';
import 'package:tic_tac_toe_flutter/features/history/data/repositories/history_repository_impl.dart';
import 'package:tic_tac_toe_flutter/features/history/domain/entities/game_record.dart';
import 'package:tic_tac_toe_flutter/features/history/domain/repositories/history_repository.dart';
import 'package:tic_tac_toe_flutter/features/history/domain/usecases/get_game_history_usecase.dart';

part 'history_providers.g.dart';

@Riverpod(keepAlive: false)
HistoryRepository historyRepository(Ref ref) {
  return HistoryRepositoryImpl(ref.watch(appDatabaseProvider));
}

@Riverpod(keepAlive: false)
GetGameHistoryUsecase getGameHistoryUsecase(Ref ref) {
  return GetGameHistoryUsecase(ref.watch(historyRepositoryProvider));
}

@riverpod
class HistoryNotifier extends _$HistoryNotifier {
  @override
  Future<List<GameRecord>> build() async {
    final usecase = ref.watch(getGameHistoryUsecaseProvider);
    final result = await usecase();
    return result.fold((exception) {
      ref.read(errorTrackingServiceProvider).captureException(exception);
      throw exception;
    }, (records) => records);
  }

  Future<void> deleteGame(int id) async {
    final result = await ref.read(historyRepositoryProvider).deleteGame(id);
    result.fold((exception) {
      ref.read(errorTrackingServiceProvider).captureException(exception);
      throw exception;
    }, (_) => ref.invalidateSelf());
  }

  Future<void> clearHistory() async {
    final result = await ref.read(historyRepositoryProvider).clearHistory();
    result.fold((exception) {
      ref.read(errorTrackingServiceProvider).captureException(exception);
      throw exception;
    }, (_) => ref.invalidateSelf());
  }
}
