// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(historyRepository)
final historyRepositoryProvider = HistoryRepositoryProvider._();

final class HistoryRepositoryProvider
    extends
        $FunctionalProvider<
          HistoryRepository,
          HistoryRepository,
          HistoryRepository
        >
    with $Provider<HistoryRepository> {
  HistoryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyRepositoryHash();

  @$internal
  @override
  $ProviderElement<HistoryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HistoryRepository create(Ref ref) {
    return historyRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HistoryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HistoryRepository>(value),
    );
  }
}

String _$historyRepositoryHash() => r'0f3a94f0eef2b1e82cf3fd47da0676d6938894e4';

@ProviderFor(getGameHistoryUsecase)
final getGameHistoryUsecaseProvider = GetGameHistoryUsecaseProvider._();

final class GetGameHistoryUsecaseProvider
    extends
        $FunctionalProvider<
          GetGameHistoryUsecase,
          GetGameHistoryUsecase,
          GetGameHistoryUsecase
        >
    with $Provider<GetGameHistoryUsecase> {
  GetGameHistoryUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getGameHistoryUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getGameHistoryUsecaseHash();

  @$internal
  @override
  $ProviderElement<GetGameHistoryUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetGameHistoryUsecase create(Ref ref) {
    return getGameHistoryUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetGameHistoryUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetGameHistoryUsecase>(value),
    );
  }
}

String _$getGameHistoryUsecaseHash() =>
    r'b795baac50c822d872abda3a384170761fb80da8';

@ProviderFor(HistoryNotifier)
final historyProvider = HistoryNotifierProvider._();

final class HistoryNotifierProvider
    extends $AsyncNotifierProvider<HistoryNotifier, List<GameRecord>> {
  HistoryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyNotifierHash();

  @$internal
  @override
  HistoryNotifier create() => HistoryNotifier();
}

String _$historyNotifierHash() => r'cd3c7915ac1be18fc62e0db04e4c564c1d8b2fb1';

abstract class _$HistoryNotifier extends $AsyncNotifier<List<GameRecord>> {
  FutureOr<List<GameRecord>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<GameRecord>>, List<GameRecord>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<GameRecord>>, List<GameRecord>>,
              AsyncValue<List<GameRecord>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
