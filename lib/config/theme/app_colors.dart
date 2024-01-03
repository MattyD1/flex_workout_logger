import 'package:flutter/material.dart';

/// Abstract class for [AppColors]
abstract class AppColors {
  /// Light Mode Surface Data
  static const surfaceLight = _SurfaceColorsLight();

  /// Dark Mode Surface Data
  static const surfaceDark = _SurfaceColorsDark();
}

/// Surface Colors Light Mode
class _SurfaceColorsLight {
  const _SurfaceColorsLight();

  Color get foreground => const Color(0xFF000000);
  Color get offForeground => const Color(0xFF0D0D0D);
  Color get mutedForeground => const Color(0xFFA6A6A6);
  Color get divider => const Color(0xFFD7D7D7);
  Color get muted => const Color(0xFFEEEEEE);
  Color get offBackground => const Color(0xFFFFFFFF);
  Color get background => const Color(0xFFF6F6F6);
}

/// Surface Colors Dark Mode
class _SurfaceColorsDark {
  const _SurfaceColorsDark();

  Color get foreground => const Color(0xFFFFFFFF);
  Color get offForeground => const Color(0xFFE0E0E0);
  Color get mutedForeground => const Color(0xFFB0B0B0);
  Color get divider => const Color(0xFF4E4E4E);
  Color get muted => const Color(0xFF333333);
  Color get offBackground => const Color(0xFF1F1F1F);
  Color get background => const Color(0xFF141414);
}
