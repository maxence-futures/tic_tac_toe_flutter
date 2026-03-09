import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/utils/logger/ttt_provider_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: initialize the error tracking SDK before runApp, for example:
  //   await SentryFlutter.init(
  //   (options) async {
  //     options.dsn = Env.sentryDsn;
  //     options.release = Release.current;
  //     options.enableAutoSessionTracking = true;
  //     options.enableWatchdogTerminationTracking = true;
  //     options.enableUserInteractionTracing = true;
  //     options.enableAutoNativeBreadcrumbs = true;

  //     options.beforeSend = (event, hint) {
  //       if (event.level != SentryLevel.fatal) {
  //         return null;
  //       }
  //       return event;
  //     };
  //   },
  //   appRunner: () async {
  //     await mainCommon(widgetsBinding);
  //   },
  // );

  // // Handler ultra-minimal - seulement les exceptions non catch
  // FlutterError.onError = (details) {
  //   // Incrémenter le compteur de crashes
  //   // _incrementCrashCount();

  //   if (details.exception.toString().contains('fatal') ||
  //       details.exception.toString().contains('crash')) {
  //     Sentry.captureException(details.exception, stackTrace: details.stack);
  //   }
  // };

  // PlatformDispatcher.instance.onError = (error, stack) {
  //   // Incrémenter le compteur de crashes
  //   // _incrementCrashCount();

  //   Sentry.captureException(error, stackTrace: stack);
  //   return true;
  // };
  // Then replace ErrorTrackingServiceImpl with SentryErrorTrackingServiceImpl
  // in services_providers.dart.

  runApp(ProviderScope(observers: [TttProviderObserver()], child: const App()));
}
