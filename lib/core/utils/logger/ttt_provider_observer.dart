import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final class TttProviderObserver extends ProviderObserver {
  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    super.didAddProvider(context, value);
    log('''
        {
          "provider": "${context.provider.name ?? context.provider.runtimeType}",
          "newValue": "$value"
        }''');
  }

  @override
  // ignore: strict_raw_type
  void didDisposeProvider(ProviderObserverContext context) {
    log('''
  {
    "provider": "${context.provider.name ?? context.provider.runtimeType}",
    "newValue": "disposed"
  }''');
    super.didDisposeProvider(context);
  }
}
