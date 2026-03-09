// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [DifficultyPage]
class DifficultyRoute extends PageRouteInfo<DifficultyRouteArgs> {
  DifficultyRoute({
    Key? key,
    required String playerName,
    List<PageRouteInfo>? children,
  }) : super(
         DifficultyRoute.name,
         args: DifficultyRouteArgs(key: key, playerName: playerName),
         initialChildren: children,
       );

  static const String name = 'DifficultyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DifficultyRouteArgs>();
      return DifficultyPage(key: args.key, playerName: args.playerName);
    },
  );
}

class DifficultyRouteArgs {
  const DifficultyRouteArgs({this.key, required this.playerName});

  final Key? key;

  final String playerName;

  @override
  String toString() {
    return 'DifficultyRouteArgs{key: $key, playerName: $playerName}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! DifficultyRouteArgs) return false;
    return key == other.key && playerName == other.playerName;
  }

  @override
  int get hashCode => key.hashCode ^ playerName.hashCode;
}

/// generated route for
/// [GamePage]
class GameRoute extends PageRouteInfo<GameRouteArgs> {
  GameRoute({
    Key? key,
    required String playerName,
    required Difficulty difficulty,
    List<PageRouteInfo>? children,
  }) : super(
         GameRoute.name,
         args: GameRouteArgs(
           key: key,
           playerName: playerName,
           difficulty: difficulty,
         ),
         initialChildren: children,
       );

  static const String name = 'GameRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GameRouteArgs>();
      return GamePage(
        key: args.key,
        playerName: args.playerName,
        difficulty: args.difficulty,
      );
    },
  );
}

class GameRouteArgs {
  const GameRouteArgs({
    this.key,
    required this.playerName,
    required this.difficulty,
  });

  final Key? key;

  final String playerName;

  final Difficulty difficulty;

  @override
  String toString() {
    return 'GameRouteArgs{key: $key, playerName: $playerName, difficulty: $difficulty}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GameRouteArgs) return false;
    return key == other.key &&
        playerName == other.playerName &&
        difficulty == other.difficulty;
  }

  @override
  int get hashCode => key.hashCode ^ playerName.hashCode ^ difficulty.hashCode;
}

/// generated route for
/// [GameReplayPage]
class GameReplayRoute extends PageRouteInfo<GameReplayRouteArgs> {
  GameReplayRoute({
    Key? key,
    required GameRecord record,
    List<PageRouteInfo>? children,
  }) : super(
         GameReplayRoute.name,
         args: GameReplayRouteArgs(key: key, record: record),
         initialChildren: children,
       );

  static const String name = 'GameReplayRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GameReplayRouteArgs>();
      return GameReplayPage(key: args.key, record: args.record);
    },
  );
}

class GameReplayRouteArgs {
  const GameReplayRouteArgs({this.key, required this.record});

  final Key? key;

  final GameRecord record;

  @override
  String toString() {
    return 'GameReplayRouteArgs{key: $key, record: $record}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GameReplayRouteArgs) return false;
    return key == other.key && record == other.record;
  }

  @override
  int get hashCode => key.hashCode ^ record.hashCode;
}

/// generated route for
/// [HistoryPage]
class HistoryRoute extends PageRouteInfo<void> {
  const HistoryRoute({List<PageRouteInfo>? children})
    : super(HistoryRoute.name, initialChildren: children);

  static const String name = 'HistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HistoryPage();
    },
  );
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [PlayerSetupPage]
class PlayerSetupRoute extends PageRouteInfo<void> {
  const PlayerSetupRoute({List<PageRouteInfo>? children})
    : super(PlayerSetupRoute.name, initialChildren: children);

  static const String name = 'PlayerSetupRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PlayerSetupPage();
    },
  );
}
