import 'package:flutter/material.dart';

/// App Colors Extension
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  /// Default constructor for the [AppColorsExtension]
  AppColorsExtension({
    /// Suface colors
    required this.foreground,
    required this.offForeground,
    required this.mutedForeground,
    required this.divider,
    required this.muted,
    required this.offBackground,
    required this.background,
  });

  /// Foreground Color
  final Color foreground;

  /// Off Foreground Color
  final Color offForeground;

  /// Muted Forground Color
  final Color mutedForeground;

  /// Divider Color
  final Color divider;

  /// Muted Color
  final Color muted;

  /// Off Background Color
  final Color offBackground;

  /// Background Color
  final Color background;

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? foreground,
    Color? offForeground,
    Color? mutedForeground,
    Color? divider,
    Color? muted,
    Color? offBackground,
    Color? background,
  }) {
    return AppColorsExtension(
      foreground: foreground ?? this.foreground,
      offForeground: offForeground ?? this.offForeground,
      mutedForeground: mutedForeground ?? this.mutedForeground,
      divider: divider ?? this.divider,
      muted: muted ?? this.muted,
      offBackground: offBackground ?? this.offBackground,
      background: background ?? this.background,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) {
      return this;
    }

    return AppColorsExtension(
      foreground: Color.lerp(foreground, other.foreground, t)!,
      offForeground: Color.lerp(offForeground, other.offForeground, t)!,
      mutedForeground: Color.lerp(mutedForeground, other.mutedForeground, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      offBackground: Color.lerp(offBackground, other.offBackground, t)!,
      background: Color.lerp(background, other.background, t)!,
    );
  }
}
