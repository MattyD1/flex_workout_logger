import 'package:flex_workout_logger/config/theme/app_colors_extension.dart';
import 'package:flex_workout_logger/config/theme/app_typography_extensions.dart';
import 'package:flex_workout_logger/config/theme/theme.dart';
import 'package:flex_workout_logger/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// A set of useful [BuildContext] extensions
extension BuildContextX on BuildContext {
  /// Extensions for quickly accessing generated localization getters
  AppLocalizations get tr => AppLocalizations.of(this)!;

  /// Extension for quickly accessing the [AppColorsExtension]
  AppColorsExtension get colorScheme => Theme.of(this).appColors;

  /// Extension for quickly accessing the [AppTextThemeExtension]
  AppTextThemeExtension get textTheme => Theme.of(this).appTextTheme;

  /// Extension for quickly accessing the [AppTheme]
  AppTheme get theme => Theme.of(this) as AppTheme;
}
