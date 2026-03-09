// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sharedPreferencesService)
final sharedPreferencesServiceProvider = SharedPreferencesServiceProvider._();

final class SharedPreferencesServiceProvider
    extends
        $FunctionalProvider<
          SharedPreferencesService,
          SharedPreferencesService,
          SharedPreferencesService
        >
    with $Provider<SharedPreferencesService> {
  SharedPreferencesServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesServiceHash();

  @$internal
  @override
  $ProviderElement<SharedPreferencesService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferencesService create(Ref ref) {
    return sharedPreferencesService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferencesService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferencesService>(value),
    );
  }
}

String _$sharedPreferencesServiceHash() =>
    r'184fc949b4f6b9bf2f74028e1a582c92bc8e5ec4';

@ProviderFor(errorTrackingService)
final errorTrackingServiceProvider = ErrorTrackingServiceProvider._();

final class ErrorTrackingServiceProvider
    extends
        $FunctionalProvider<
          ErrorTrackingService,
          ErrorTrackingService,
          ErrorTrackingService
        >
    with $Provider<ErrorTrackingService> {
  ErrorTrackingServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'errorTrackingServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$errorTrackingServiceHash();

  @$internal
  @override
  $ProviderElement<ErrorTrackingService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ErrorTrackingService create(Ref ref) {
    return errorTrackingService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ErrorTrackingService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ErrorTrackingService>(value),
    );
  }
}

String _$errorTrackingServiceHash() =>
    r'1d6ea8efab21b0418429abdfd86454ac3eeedaea';
