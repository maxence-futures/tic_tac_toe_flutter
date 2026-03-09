// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $GameRecordDriftModelTable extends GameRecordDriftModel
    with TableInfo<$GameRecordDriftModelTable, GameRecordDriftModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GameRecordDriftModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _playerNameMeta = const VerificationMeta(
    'playerName',
  );
  @override
  late final GeneratedColumn<String> playerName = GeneratedColumn<String>(
    'player_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resultMeta = const VerificationMeta('result');
  @override
  late final GeneratedColumn<String> result = GeneratedColumn<String>(
    'result',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _movesJsonMeta = const VerificationMeta(
    'movesJson',
  );
  @override
  late final GeneratedColumn<String> movesJson = GeneratedColumn<String>(
    'moves_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _playedAtMeta = const VerificationMeta(
    'playedAt',
  );
  @override
  late final GeneratedColumn<DateTime> playedAt = GeneratedColumn<DateTime>(
    'played_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    playerName,
    difficulty,
    result,
    movesJson,
    playedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'game_record_drift_model';
  @override
  VerificationContext validateIntegrity(
    Insertable<GameRecordDriftModelData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('player_name')) {
      context.handle(
        _playerNameMeta,
        playerName.isAcceptableOrUnknown(data['player_name']!, _playerNameMeta),
      );
    } else if (isInserting) {
      context.missing(_playerNameMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('result')) {
      context.handle(
        _resultMeta,
        result.isAcceptableOrUnknown(data['result']!, _resultMeta),
      );
    } else if (isInserting) {
      context.missing(_resultMeta);
    }
    if (data.containsKey('moves_json')) {
      context.handle(
        _movesJsonMeta,
        movesJson.isAcceptableOrUnknown(data['moves_json']!, _movesJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_movesJsonMeta);
    }
    if (data.containsKey('played_at')) {
      context.handle(
        _playedAtMeta,
        playedAt.isAcceptableOrUnknown(data['played_at']!, _playedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_playedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GameRecordDriftModelData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GameRecordDriftModelData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      playerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}player_name'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
      result: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result'],
      )!,
      movesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}moves_json'],
      )!,
      playedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}played_at'],
      )!,
    );
  }

  @override
  $GameRecordDriftModelTable createAlias(String alias) {
    return $GameRecordDriftModelTable(attachedDatabase, alias);
  }
}

class GameRecordDriftModelData extends DataClass
    implements Insertable<GameRecordDriftModelData> {
  final int id;
  final String playerName;
  final String difficulty;

  /// `'win'`, `'loss'`, or `'draw'`.
  final String result;

  /// JSON-encoded list of [GameMove] objects.
  final String movesJson;
  final DateTime playedAt;
  const GameRecordDriftModelData({
    required this.id,
    required this.playerName,
    required this.difficulty,
    required this.result,
    required this.movesJson,
    required this.playedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['player_name'] = Variable<String>(playerName);
    map['difficulty'] = Variable<String>(difficulty);
    map['result'] = Variable<String>(result);
    map['moves_json'] = Variable<String>(movesJson);
    map['played_at'] = Variable<DateTime>(playedAt);
    return map;
  }

  GameRecordDriftModelCompanion toCompanion(bool nullToAbsent) {
    return GameRecordDriftModelCompanion(
      id: Value(id),
      playerName: Value(playerName),
      difficulty: Value(difficulty),
      result: Value(result),
      movesJson: Value(movesJson),
      playedAt: Value(playedAt),
    );
  }

  factory GameRecordDriftModelData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameRecordDriftModelData(
      id: serializer.fromJson<int>(json['id']),
      playerName: serializer.fromJson<String>(json['playerName']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      result: serializer.fromJson<String>(json['result']),
      movesJson: serializer.fromJson<String>(json['movesJson']),
      playedAt: serializer.fromJson<DateTime>(json['playedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'playerName': serializer.toJson<String>(playerName),
      'difficulty': serializer.toJson<String>(difficulty),
      'result': serializer.toJson<String>(result),
      'movesJson': serializer.toJson<String>(movesJson),
      'playedAt': serializer.toJson<DateTime>(playedAt),
    };
  }

  GameRecordDriftModelData copyWith({
    int? id,
    String? playerName,
    String? difficulty,
    String? result,
    String? movesJson,
    DateTime? playedAt,
  }) => GameRecordDriftModelData(
    id: id ?? this.id,
    playerName: playerName ?? this.playerName,
    difficulty: difficulty ?? this.difficulty,
    result: result ?? this.result,
    movesJson: movesJson ?? this.movesJson,
    playedAt: playedAt ?? this.playedAt,
  );
  GameRecordDriftModelData copyWithCompanion(
    GameRecordDriftModelCompanion data,
  ) {
    return GameRecordDriftModelData(
      id: data.id.present ? data.id.value : this.id,
      playerName: data.playerName.present
          ? data.playerName.value
          : this.playerName,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      result: data.result.present ? data.result.value : this.result,
      movesJson: data.movesJson.present ? data.movesJson.value : this.movesJson,
      playedAt: data.playedAt.present ? data.playedAt.value : this.playedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GameRecordDriftModelData(')
          ..write('id: $id, ')
          ..write('playerName: $playerName, ')
          ..write('difficulty: $difficulty, ')
          ..write('result: $result, ')
          ..write('movesJson: $movesJson, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, playerName, difficulty, result, movesJson, playedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameRecordDriftModelData &&
          other.id == this.id &&
          other.playerName == this.playerName &&
          other.difficulty == this.difficulty &&
          other.result == this.result &&
          other.movesJson == this.movesJson &&
          other.playedAt == this.playedAt);
}

class GameRecordDriftModelCompanion
    extends UpdateCompanion<GameRecordDriftModelData> {
  final Value<int> id;
  final Value<String> playerName;
  final Value<String> difficulty;
  final Value<String> result;
  final Value<String> movesJson;
  final Value<DateTime> playedAt;
  const GameRecordDriftModelCompanion({
    this.id = const Value.absent(),
    this.playerName = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.result = const Value.absent(),
    this.movesJson = const Value.absent(),
    this.playedAt = const Value.absent(),
  });
  GameRecordDriftModelCompanion.insert({
    this.id = const Value.absent(),
    required String playerName,
    required String difficulty,
    required String result,
    required String movesJson,
    required DateTime playedAt,
  }) : playerName = Value(playerName),
       difficulty = Value(difficulty),
       result = Value(result),
       movesJson = Value(movesJson),
       playedAt = Value(playedAt);
  static Insertable<GameRecordDriftModelData> custom({
    Expression<int>? id,
    Expression<String>? playerName,
    Expression<String>? difficulty,
    Expression<String>? result,
    Expression<String>? movesJson,
    Expression<DateTime>? playedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playerName != null) 'player_name': playerName,
      if (difficulty != null) 'difficulty': difficulty,
      if (result != null) 'result': result,
      if (movesJson != null) 'moves_json': movesJson,
      if (playedAt != null) 'played_at': playedAt,
    });
  }

  GameRecordDriftModelCompanion copyWith({
    Value<int>? id,
    Value<String>? playerName,
    Value<String>? difficulty,
    Value<String>? result,
    Value<String>? movesJson,
    Value<DateTime>? playedAt,
  }) {
    return GameRecordDriftModelCompanion(
      id: id ?? this.id,
      playerName: playerName ?? this.playerName,
      difficulty: difficulty ?? this.difficulty,
      result: result ?? this.result,
      movesJson: movesJson ?? this.movesJson,
      playedAt: playedAt ?? this.playedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (playerName.present) {
      map['player_name'] = Variable<String>(playerName.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (result.present) {
      map['result'] = Variable<String>(result.value);
    }
    if (movesJson.present) {
      map['moves_json'] = Variable<String>(movesJson.value);
    }
    if (playedAt.present) {
      map['played_at'] = Variable<DateTime>(playedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameRecordDriftModelCompanion(')
          ..write('id: $id, ')
          ..write('playerName: $playerName, ')
          ..write('difficulty: $difficulty, ')
          ..write('result: $result, ')
          ..write('movesJson: $movesJson, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $GameRecordDriftModelTable gameRecordDriftModel =
      $GameRecordDriftModelTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [gameRecordDriftModel];
}

typedef $$GameRecordDriftModelTableCreateCompanionBuilder =
    GameRecordDriftModelCompanion Function({
      Value<int> id,
      required String playerName,
      required String difficulty,
      required String result,
      required String movesJson,
      required DateTime playedAt,
    });
typedef $$GameRecordDriftModelTableUpdateCompanionBuilder =
    GameRecordDriftModelCompanion Function({
      Value<int> id,
      Value<String> playerName,
      Value<String> difficulty,
      Value<String> result,
      Value<String> movesJson,
      Value<DateTime> playedAt,
    });

class $$GameRecordDriftModelTableFilterComposer
    extends Composer<_$AppDatabase, $GameRecordDriftModelTable> {
  $$GameRecordDriftModelTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get playerName => $composableBuilder(
    column: $table.playerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get movesJson => $composableBuilder(
    column: $table.movesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get playedAt => $composableBuilder(
    column: $table.playedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GameRecordDriftModelTableOrderingComposer
    extends Composer<_$AppDatabase, $GameRecordDriftModelTable> {
  $$GameRecordDriftModelTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get playerName => $composableBuilder(
    column: $table.playerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get movesJson => $composableBuilder(
    column: $table.movesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get playedAt => $composableBuilder(
    column: $table.playedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GameRecordDriftModelTableAnnotationComposer
    extends Composer<_$AppDatabase, $GameRecordDriftModelTable> {
  $$GameRecordDriftModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get playerName => $composableBuilder(
    column: $table.playerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get result =>
      $composableBuilder(column: $table.result, builder: (column) => column);

  GeneratedColumn<String> get movesJson =>
      $composableBuilder(column: $table.movesJson, builder: (column) => column);

  GeneratedColumn<DateTime> get playedAt =>
      $composableBuilder(column: $table.playedAt, builder: (column) => column);
}

class $$GameRecordDriftModelTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GameRecordDriftModelTable,
          GameRecordDriftModelData,
          $$GameRecordDriftModelTableFilterComposer,
          $$GameRecordDriftModelTableOrderingComposer,
          $$GameRecordDriftModelTableAnnotationComposer,
          $$GameRecordDriftModelTableCreateCompanionBuilder,
          $$GameRecordDriftModelTableUpdateCompanionBuilder,
          (
            GameRecordDriftModelData,
            BaseReferences<
              _$AppDatabase,
              $GameRecordDriftModelTable,
              GameRecordDriftModelData
            >,
          ),
          GameRecordDriftModelData,
          PrefetchHooks Function()
        > {
  $$GameRecordDriftModelTableTableManager(
    _$AppDatabase db,
    $GameRecordDriftModelTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GameRecordDriftModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GameRecordDriftModelTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$GameRecordDriftModelTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> playerName = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<String> result = const Value.absent(),
                Value<String> movesJson = const Value.absent(),
                Value<DateTime> playedAt = const Value.absent(),
              }) => GameRecordDriftModelCompanion(
                id: id,
                playerName: playerName,
                difficulty: difficulty,
                result: result,
                movesJson: movesJson,
                playedAt: playedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String playerName,
                required String difficulty,
                required String result,
                required String movesJson,
                required DateTime playedAt,
              }) => GameRecordDriftModelCompanion.insert(
                id: id,
                playerName: playerName,
                difficulty: difficulty,
                result: result,
                movesJson: movesJson,
                playedAt: playedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GameRecordDriftModelTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GameRecordDriftModelTable,
      GameRecordDriftModelData,
      $$GameRecordDriftModelTableFilterComposer,
      $$GameRecordDriftModelTableOrderingComposer,
      $$GameRecordDriftModelTableAnnotationComposer,
      $$GameRecordDriftModelTableCreateCompanionBuilder,
      $$GameRecordDriftModelTableUpdateCompanionBuilder,
      (
        GameRecordDriftModelData,
        BaseReferences<
          _$AppDatabase,
          $GameRecordDriftModelTable,
          GameRecordDriftModelData
        >,
      ),
      GameRecordDriftModelData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GameRecordDriftModelTableTableManager get gameRecordDriftModel =>
      $$GameRecordDriftModelTableTableManager(_db, _db.gameRecordDriftModel);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'59cce38d45eeaba199eddd097d8e149d66f9f3e1';
