import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  static ThemeData get light {
    final colors = AppColorsTheme.light();
    return ThemeData(
      useMaterial3: true,
      textTheme: AppTypography.textTheme,
      extensions: [colors],
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme.light(
        primary: colors.primary,
        onPrimary: colors.onPrimary,
        secondary: colors.secondary,
        onSecondary: colors.onSecondary,
        surface: colors.surface,
        onSurface: colors.text,
        error: colors.error,
      ),
    );
  }

  static ThemeData get dark {
    final colors = AppColorsTheme.dark();
    return ThemeData(
      useMaterial3: true,
      textTheme: AppTypography.textTheme,
      extensions: [colors],
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme.dark(
        primary: colors.primary,
        onPrimary: colors.onPrimary,
        secondary: colors.secondary,
        onSecondary: colors.onSecondary,
        surface: colors.surface,
        onSurface: colors.text,
        error: colors.error,
      ),
    );
  }
}
