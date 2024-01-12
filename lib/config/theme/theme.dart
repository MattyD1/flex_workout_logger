import 'package:flex_workout_logger/config/theme/app_colors.dart';
import 'package:flex_workout_logger/config/theme/app_colors_extension.dart';
import 'package:flex_workout_logger/config/theme/app_typography.dart';
import 'package:flex_workout_logger/config/theme/app_typography_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// App Theme
class AppTheme with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  /// Theme Mode Getter
  ThemeMode get themeMode => _themeMode;

  /// Theme Mode Setter
  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  static const _textTheme = AppTextThemeExtension(
    bodySmall: AppTypography.bodySmall,
    bodyMedium: AppTypography.bodyMedium,
    headlineLarge: AppTypography.headlineLarge,
    headlineSmall: AppTypography.headlineSmall,
    titleLarge: AppTypography.titleLarge,
    titleSmall: AppTypography.titleSmall,
    label: AppTypography.label,
    listTitle: AppTypography.listTitle,
    listSubtitle: AppTypography.listSubtitle,
  );

  /// Light Mode Theme Data
  static final light = ThemeData.light(useMaterial3: true).copyWith(
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.surfaceLight.foreground,
      selectionColor: AppColors.surfaceLight.foreground.withOpacity(0.3),
      selectionHandleColor: AppColors.surfaceLight.foreground,
    ),
    cupertinoOverrideTheme: CupertinoThemeData(
      primaryColor: AppColors.surfaceLight.foreground,
    ),
    extensions: [
      _lightAppColors,
      _textTheme,
    ],
  );

  static final _lightAppColors = AppColorsExtension(
    foreground: AppColors.surfaceLight.foreground,
    offForeground: AppColors.surfaceLight.offForeground,
    mutedForeground: AppColors.surfaceLight.mutedForeground,
    divider: AppColors.surfaceLight.divider,
    muted: AppColors.surfaceLight.muted,
    offBackground: AppColors.surfaceLight.offBackground,
    background: AppColors.surfaceLight.background,
  );

  /// Dark Mode Theme Data
  static final dark = ThemeData.dark(useMaterial3: true).copyWith(
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.surfaceDark.foreground,
      selectionColor: AppColors.surfaceDark.foreground.withOpacity(0.3),
      selectionHandleColor: AppColors.surfaceDark.foreground,
    ),
    cupertinoOverrideTheme: CupertinoThemeData(
      primaryColor: AppColors.surfaceDark.foreground,
    ),
    extensions: [
      _darkAppColors,
      _textTheme,
    ],
  );

  static final _darkAppColors = AppColorsExtension(
    foreground: AppColors.surfaceDark.foreground,
    offForeground: AppColors.surfaceDark.offForeground,
    mutedForeground: AppColors.surfaceDark.mutedForeground,
    divider: AppColors.surfaceDark.divider,
    muted: AppColors.surfaceDark.muted,
    offBackground: AppColors.surfaceDark.offBackground,
    background: AppColors.surfaceDark.background,
  );
}

///
extension AppThemeExtension on ThemeData {
  ///
  AppColorsExtension get appColors =>
      extension<AppColorsExtension>() ?? AppTheme._darkAppColors;

  ///
  AppTextThemeExtension get appTextTheme =>
      extension<AppTextThemeExtension>() ?? AppTheme._textTheme;
}
