import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_flutter/core/services/error_tracking/error_tracking_service.dart';
import 'package:tic_tac_toe_flutter/core/services/error_tracking/impl/error_tracking_service_impl.dart';

void main() {
  group('ErrorTrackingServiceImpl', () {
    late ErrorTrackingService service;

    setUp(() {
      service = const ErrorTrackingServiceImpl();
    });

    test('captureException completes without throwing', () async {
      await expectLater(
        service.captureException(
          Exception('test error'),
          stackTrace: StackTrace.current,
          extra: {'key': 'value'},
        ),
        completes,
      );
    });

    test('captureException with only required args completes', () async {
      await expectLater(
        service.captureException(Exception('minimal')),
        completes,
      );
    });

    test('captureMessage completes for every severity level', () async {
      for (final level in ErrorSeverity.values) {
        await expectLater(
          service.captureMessage('test message', level: level),
          completes,
        );
      }
    });

    test('setUser completes with all fields provided', () async {
      await expectLater(
        service.setUser(id: '42', username: 'alice', email: 'alice@example.com'),
        completes,
      );
    });

    test('setUser completes with all fields null', () async {
      await expectLater(
        service.setUser(),
        completes,
      );
    });

    test('clearUser completes without throwing', () async {
      await expectLater(service.clearUser(), completes);
    });

    test('addBreadcrumb completes with all fields provided', () async {
      await expectLater(
        service.addBreadcrumb(
          'user tapped play',
          category: 'ui',
          data: {'screen': 'home'},
        ),
        completes,
      );
    });

    test('addBreadcrumb completes with only message', () async {
      await expectLater(
        service.addBreadcrumb('minimal breadcrumb'),
        completes,
      );
    });
  });
}
