// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(gameRepository)
final gameRepositoryProvider = GameRepositoryProvider._();

final class GameRepositoryProvider
    extends $FunctionalProvider<GameRepository, GameRepository, GameRepository>
    with $Provider<GameRepository> {
  GameRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gameRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gameRepositoryHash();

  @$internal
  @override
  $ProviderElement<GameRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GameRepository create(Ref ref) {
    return gameRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GameRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GameRepository>(value),
    );
  }
}

String _$gameRepositoryHash() => r'd41a05eb68650785071defc32640dd1922cb9508';

@ProviderFor(getCpuMoveUsecase)
final getCpuMoveUsecaseProvider = GetCpuMoveUsecaseProvider._();

final class GetCpuMoveUsecaseProvider
    extends
        $FunctionalProvider<
          GetCpuMoveUsecase,
          GetCpuMoveUsecase,
          GetCpuMoveUsecase
        >
    with $Provider<GetCpuMoveUsecase> {
  GetCpuMoveUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCpuMoveUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCpuMoveUsecaseHash();

  @$internal
  @override
  $ProviderElement<GetCpuMoveUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetCpuMoveUsecase create(Ref ref) {
    return getCpuMoveUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetCpuMoveUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetCpuMoveUsecase>(value),
    );
  }
}

String _$getCpuMoveUsecaseHash() => r'4010cb31d1ddfcd0402789cbaf27148d80048b9a';

@ProviderFor(saveGameUsecase)
final saveGameUsecaseProvider = SaveGameUsecaseProvider._();

final class SaveGameUsecaseProvider
    extends
        $FunctionalProvider<SaveGameUsecase, SaveGameUsecase, SaveGameUsecase>
    with $Provider<SaveGameUsecase> {
  SaveGameUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveGameUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveGameUsecaseHash();

  @$internal
  @override
  $ProviderElement<SaveGameUsecase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SaveGameUsecase create(Ref ref) {
    return saveGameUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveGameUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveGameUsecase>(value),
    );
  }
}

String _$saveGameUsecaseHash() => r'6a746544ece7df1e22616dc3ffd250103d5e9777';

@ProviderFor(GameNotifier)
final gameProvider = GameNotifierFamily._();

final class GameNotifierProvider
    extends $NotifierProvider<GameNotifier, GameState> {
  GameNotifierProvider._({
    required GameNotifierFamily super.from,
    required (String, Difficulty) super.argument,
  }) : super(
         retry: null,
         name: r'gameProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$gameNotifierHash();

  @override
  String toString() {
    return r'gameProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  GameNotifier create() => GameNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GameState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GameState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GameNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$gameNotifierHash() => r'fb171ff8c18e656d78d1a755e9047d03ec03bc81';

final class GameNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          GameNotifier,
          GameState,
          GameState,
          GameState,
          (String, Difficulty)
        > {
  GameNotifierFamily._()
    : super(
        retry: null,
        name: r'gameProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GameNotifierProvider call(String playerName, Difficulty difficulty) =>
      GameNotifierProvider._(argument: (playerName, difficulty), from: this);

  @override
  String toString() => r'gameProvider';
}

abstract class _$GameNotifier extends $Notifier<GameState> {
  late final _$args = ref.$arg as (String, Difficulty);
  String get playerName => _$args.$1;
  Difficulty get difficulty => _$args.$2;

  GameState build(String playerName, Difficulty difficulty);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<GameState, GameState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GameState, GameState>,
              GameState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
