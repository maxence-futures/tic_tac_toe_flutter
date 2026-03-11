import 'package:flutter/material.dart';

import 'package:tic_tac_toe_flutter/core/l10n/app_localizations.dart';
import 'package:tic_tac_toe_flutter/core/ui/theme/app_colors.dart';
import 'package:tic_tac_toe_flutter/core/ui/theme/app_durations.dart';

extension BuildContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  ThemeData get theme => Theme.of(this);

  AppColorsTheme get appColors => theme.appColors;

  AppLocalizations get locals => AppLocalizations.of(this);

  /// Animation duration tokens — access via [AppDurations].
  AppDurations get durations => const AppDurations();
}
