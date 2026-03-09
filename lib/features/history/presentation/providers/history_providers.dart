import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/app_database.dart';
import '../../data/repositories/history_repository_impl.dart';
import '../../domain/entities/game_record.dart';
import '../../domain/repositories/history_repository.dart';
import '../../domain/usecases/get_game_history_usecase.dart';

part 'history_providers.g.dart';

@Riverpod(keepAlive: false)
HistoryRepository historyRepository(Ref ref) {
  return HistoryRepositoryImpl(ref.watch(appDatabaseProvider));
}

@riverpod
class HistoryNotifier extends _$HistoryNotifier {
  @override
  Future<List<GameRecord>> build() async {
    final usecase = GetGameHistoryUsecase(ref.watch(historyRepositoryProvider));
    final result = await usecase();
    return result.fold((_) => [], (records) => records);
  }

  Future<void> deleteGame(int id) async {
    await ref.read(historyRepositoryProvider).deleteGame(id);
    ref.invalidateSelf();
  }
}
