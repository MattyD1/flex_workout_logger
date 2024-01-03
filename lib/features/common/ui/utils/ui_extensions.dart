import 'package:flex_workout_logger/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// A set of useful [BuildContext] extensions
extension BuildContextX on BuildContext {
  /// Extensions for quickly accessing generated localization getters
  AppLocalizations get tr => AppLocalizations.of(this)!;
}
