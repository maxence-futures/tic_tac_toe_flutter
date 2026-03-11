import 'package:flutter/material.dart';

class AppColorsTheme extends ThemeExtension<AppColorsTheme> {
  // ---------------------------------------------------------------------------
  // Raw palette
  // ---------------------------------------------------------------------------

  static const _white = Color(0xFFFFFFFF);
  static const _blue = Color(0xFF2574FF);
  static const _orange = Color(0xFFEE7527);
  static const _red = Color(0xFFE6311F);
  static const _greyLight = Color(0xFFF0F1F5);
  static const _greyMid = Color(0xFFA0A7BC);
  static const _greyDark = Color(0xFF353C52);
  static const _darkSurface = Color(0xFF1A1D2E);
  static const _darkBackground = Color(0xFF12141F);

  // ---------------------------------------------------------------------------
  // Semantic fields
  // ---------------------------------------------------------------------------

  final Color background;
  final Color surface;
  final Color text;
  final Color textSubtle;
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color error;
  final Color disabled;
  final Color border;

  // ---------------------------------------------------------------------------
  // Constructor
  // ---------------------------------------------------------------------------

  const AppColorsTheme._internal({
    required this.background,
    required this.surface,
    required this.text,
    required this.textSubtle,
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.error,
    required this.disabled,
    required this.border,
  });

  // ---------------------------------------------------------------------------
  // Factories
  // ---------------------------------------------------------------------------

  factory AppColorsTheme.light() => const AppColorsTheme._internal(
        background: _white,
        surface: _greyLight,
        text: _greyDark,
        textSubtle: _greyMid,
        primary: _blue,
        onPrimary: _white,
        secondary: _orange,
        onSecondary: _white,
        error: _red,
        disabled: _greyMid,
        border: _greyMid,
      );

  factory AppColorsTheme.dark() => const AppColorsTheme._internal(
        background: _darkBackground,
        surface: _darkSurface,
        text: _white,
        textSubtle: _greyMid,
        primary: _blue,
        onPrimary: _white,
        secondary: _orange,
        onSecondary: _white,
        error: _red,
        disabled: _greyDark,
        border: _greyDark,
      );

  // ---------------------------------------------------------------------------
  // ThemeExtension overrides
  // ---------------------------------------------------------------------------

  @override
  AppColorsTheme copyWith({
    Color? background,
    Color? surface,
    Color? text,
    Color? textSubtle,
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
    Color? error,
    Color? disabled,
    Color? border,
  }) =>
      AppColorsTheme._internal(
        background: background ?? this.background,
        surface: surface ?? this.surface,
        text: text ?? this.text,
        textSubtle: textSubtle ?? this.textSubtle,
        primary: primary ?? this.primary,
        onPrimary: onPrimary ?? this.onPrimary,
        secondary: secondary ?? this.secondary,
        onSecondary: onSecondary ?? this.onSecondary,
        error: error ?? this.error,
        disabled: disabled ?? this.disabled,
        border: border ?? this.border,
      );

  @override
  AppColorsTheme lerp(covariant AppColorsTheme? other, double t) {
    if (other == null) return this;
    return AppColorsTheme._internal(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      text: Color.lerp(text, other.text, t)!,
      textSubtle: Color.lerp(textSubtle, other.textSubtle, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      error: Color.lerp(error, other.error, t)!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
      border: Color.lerp(border, other.border, t)!,
    );
  }
}

extension AppColorsThemeData on ThemeData {
  AppColorsTheme get appColors => extension<AppColorsTheme>()!;
}
