/// Severity level for messages sent to the error tracking backend.
enum ErrorSeverity { debug, info, warning, error, fatal }

/// Contract for error tracking (e.g. Sentry, Datadog, Firebase Crashlytics).
///
/// All methods are fire-and-forget: they return [Future<void>] so callers
/// can await them without caring about the backend response.
abstract interface class ErrorTrackingService {
  /// Reports a caught [exception] with its optional [stackTrace].
  ///
  /// Use [extra] to attach arbitrary key-value metadata (e.g. request id,
  /// feature flag values) that helps reproduce the issue.
  Future<void> captureException(
    Object exception, {
    StackTrace? stackTrace,
    Map<String, dynamic>? extra,
  });

  /// Reports a structured [message] at the given severity [level].
  ///
  /// Not yet called in the app — available for non-exception events
  /// (e.g. "user reached rate limit", analytics checkpoints).
  Future<void> captureMessage(
    String message, {
    ErrorSeverity level = ErrorSeverity.info,
  });

  /// Attaches user identity to subsequent events.
  ///
  /// Not yet called in the app — useful once authentication is introduced
  /// to correlate errors with specific users.
  Future<void> setUser({
    String? id,
    String? username,
    String? email,
  });

  /// Removes any previously set user context.
  ///
  /// Not yet called in the app — pair with [setUser] on sign-out.
  Future<void> clearUser();

  /// Adds a breadcrumb to the current event scope.
  ///
  /// Not yet called in the app — useful to trace navigation, network calls,
  /// or user actions that led up to an error.
  Future<void> addBreadcrumb(
    String message, {
    String? category,
    Map<String, dynamic>? data,
  });
}
