import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/game/domain/entities/difficulty.dart';
import '../../features/game/presentation/pages/difficulty_page.dart';
import '../../features/game/presentation/pages/game_page.dart';
import '../../features/player/presentation/pages/player_setup_page.dart';
import '../../features/history/domain/entities/game_record.dart';
import '../../features/history/presentation/pages/game_replay_page.dart';
import '../../features/history/presentation/pages/history_page.dart';
import '../../features/home/presentation/pages/home_page.dart';

part 'app_router.g.dart';
part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: PlayerSetupRoute.page),
    AutoRoute(page: DifficultyRoute.page),
    AutoRoute(page: GameRoute.page),
    AutoRoute(page: HistoryRoute.page),
    AutoRoute(page: GameReplayRoute.page),
  ];
}

@Riverpod(keepAlive: true)
AppRouter router(Ref ref) => AppRouter();
