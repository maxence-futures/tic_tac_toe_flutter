// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(playerProfileRepository)
final playerProfileRepositoryProvider = PlayerProfileRepositoryProvider._();

final class PlayerProfileRepositoryProvider
    extends
        $FunctionalProvider<
          PlayerProfileRepository,
          PlayerProfileRepository,
          PlayerProfileRepository
        >
    with $Provider<PlayerProfileRepository> {
  PlayerProfileRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playerProfileRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playerProfileRepositoryHash();

  @$internal
  @override
  $ProviderElement<PlayerProfileRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PlayerProfileRepository create(Ref ref) {
    return playerProfileRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlayerProfileRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlayerProfileRepository>(value),
    );
  }
}

String _$playerProfileRepositoryHash() =>
    r'c683d7341f2ba1cc38898d945179a4c317ff1b87';

@ProviderFor(PlayerNotifier)
final playerProvider = PlayerNotifierProvider._();

final class PlayerNotifierProvider
    extends $AsyncNotifierProvider<PlayerNotifier, PlayerState> {
  PlayerNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playerNotifierHash();

  @$internal
  @override
  PlayerNotifier create() => PlayerNotifier();
}

String _$playerNotifierHash() => r'635b20cb37e1f1408808c35e2c9c8886ebf26bc1';

abstract class _$PlayerNotifier extends $AsyncNotifier<PlayerState> {
  FutureOr<PlayerState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PlayerState>, PlayerState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PlayerState>, PlayerState>,
              AsyncValue<PlayerState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
