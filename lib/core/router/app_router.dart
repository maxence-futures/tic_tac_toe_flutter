import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:tic_tac_toe_flutter/features/game/domain/entities/difficulty.dart';
import 'package:tic_tac_toe_flutter/features/game/presentation/pages/difficulty_page.dart';
import 'package:tic_tac_toe_flutter/features/game/presentation/pages/game_page.dart';
import 'package:tic_tac_toe_flutter/features/history/domain/entities/game_record.dart';
import 'package:tic_tac_toe_flutter/features/history/presentation/pages/game_replay_page.dart';
import 'package:tic_tac_toe_flutter/features/history/presentation/pages/history_page.dart';
import 'package:tic_tac_toe_flutter/features/home/presentation/pages/home_page.dart';
import 'package:tic_tac_toe_flutter/features/player/presentation/pages/player_setup_page.dart';

part 'app_router.g.dart';
part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, path: '/', initial: true),
    AutoRoute(page: PlayerSetupRoute.page, path: '/player-setup'),
    AutoRoute(page: DifficultyRoute.page, path: '/difficulty'),
    AutoRoute(page: GameRoute.page, path: '/game'),
    AutoRoute(page: HistoryRoute.page, path: '/history'),
    AutoRoute(page: GameReplayRoute.page, path: '/history/replay'),
  ];
}

@Riverpod(keepAlive: true)
AppRouter router(Ref ref) => AppRouter();
