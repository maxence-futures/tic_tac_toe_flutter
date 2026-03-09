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
  /// Useful for non-exception events (e.g. "user reached rate limit").
  Future<void> captureMessage(
    String message, {
    ErrorSeverity level = ErrorSeverity.info,
  });

  /// Attaches user identity to subsequent events.
  ///
  /// Pass [null] for fields that are unavailable (e.g. anonymous user has
  /// no [email]).
  Future<void> setUser({
    String? id,
    String? username,
    String? email,
  });

  /// Removes any previously set user context.
  Future<void> clearUser();

  /// Adds a breadcrumb to the current event scope.
  ///
  /// Breadcrumbs are a chronological trail of events (navigation, network
  /// calls, user actions) that help understand what led to an error.
  Future<void> addBreadcrumb(
    String message, {
    String? category,
    Map<String, dynamic>? data,
  });
}
