// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_replay_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Tracks the current replay step (0 = empty board, N = after N moves).

@ProviderFor(GameReplayNotifier)
final gameReplayProvider = GameReplayNotifierFamily._();

/// Tracks the current replay step (0 = empty board, N = after N moves).
final class GameReplayNotifierProvider
    extends $NotifierProvider<GameReplayNotifier, int> {
  /// Tracks the current replay step (0 = empty board, N = after N moves).
  GameReplayNotifierProvider._({
    required GameReplayNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'gameReplayProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$gameReplayNotifierHash();

  @override
  String toString() {
    return r'gameReplayProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  GameReplayNotifier create() => GameReplayNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GameReplayNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$gameReplayNotifierHash() =>
    r'1a329bcc18e9d43801f58b71cc6b06bfdaec1377';

/// Tracks the current replay step (0 = empty board, N = after N moves).

final class GameReplayNotifierFamily extends $Family
    with $ClassFamilyOverride<GameReplayNotifier, int, int, int, int> {
  GameReplayNotifierFamily._()
    : super(
        retry: null,
        name: r'gameReplayProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Tracks the current replay step (0 = empty board, N = after N moves).

  GameReplayNotifierProvider call(int recordId) =>
      GameReplayNotifierProvider._(argument: recordId, from: this);

  @override
  String toString() => r'gameReplayProvider';
}

/// Tracks the current replay step (0 = empty board, N = after N moves).

abstract class _$GameReplayNotifier extends $Notifier<int> {
  late final _$args = ref.$arg as int;
  int get recordId => _$args;

  int build(int recordId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
