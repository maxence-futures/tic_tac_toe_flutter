import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../error_tracking/error_tracking_service.dart';
import '../error_tracking/impl/error_tracking_service_impl.dart';
import '../shared_preferences/impl/shared_preferences_service_impl.dart';
import '../shared_preferences/shared_preferences_service.dart';

part 'services_providers.g.dart';

@Riverpod(keepAlive: true)
SharedPreferencesService sharedPreferencesService(Ref ref) {
  return SharedPreferencesServiceImpl(SharedPreferencesAsync());
}

@Riverpod(keepAlive: true)
ErrorTrackingService errorTrackingService(Ref ref) {
  return const ErrorTrackingServiceImpl();
}
