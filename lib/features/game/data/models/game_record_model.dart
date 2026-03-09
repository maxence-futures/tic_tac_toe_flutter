import 'package:drift/drift.dart';

/// Drift table that stores one record per completed game.
class GameRecordDriftModel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get playerName => text()();
  TextColumn get difficulty => text()();

  /// `'win'`, `'loss'`, or `'draw'`.
  TextColumn get result => text()();

  /// JSON-encoded list of [GameMove] objects.
  TextColumn get movesJson => text()();

  DateTimeColumn get playedAt => dateTime()();
}
