import 'dart:developer' as dev;

import 'package:tic_tac_toe_flutter/core/services/error_tracking/error_tracking_service.dart';

/// Stub implementation of [ErrorTrackingService].
///
/// Logs every call to the Dart developer console instead of sending data to a
/// real backend. Replace this with a Sentry / Crashlytics adapter when ready.
final class ErrorTrackingServiceImpl implements ErrorTrackingService {
  const ErrorTrackingServiceImpl();

  @override
  Future<void> captureException(
    Object exception, {
    StackTrace? stackTrace,
    Map<String, dynamic>? extra,
  }) async {
    dev.log(
      '[ErrorTracking] captureException: $exception'
      '${extra != null ? ' | extra: $extra' : ''}',
      error: exception,
      stackTrace: stackTrace,
      name: 'ErrorTrackingService',
    );
  }

  @override
  Future<void> captureMessage(
    String message, {
    ErrorSeverity level = ErrorSeverity.info,
  }) async {
    dev.log(
      '[ErrorTracking] captureMessage(${level.name}): $message',
      name: 'ErrorTrackingService',
    );
  }

  @override
  Future<void> setUser({
    String? id,
    String? username,
    String? email,
  }) async {
    dev.log(
      '[ErrorTracking] setUser: id=$id, username=$username, email=$email',
      name: 'ErrorTrackingService',
    );
  }

  @override
  Future<void> clearUser() async {
    dev.log('[ErrorTracking] clearUser', name: 'ErrorTrackingService');
  }

  @override
  Future<void> addBreadcrumb(
    String message, {
    String? category,
    Map<String, dynamic>? data,
  }) async {
    dev.log(
      '[ErrorTracking] addBreadcrumb: $message'
      '${category != null ? ' | category: $category' : ''}'
      '${data != null ? ' | data: $data' : ''}',
      name: 'ErrorTrackingService',
    );
  }
}
