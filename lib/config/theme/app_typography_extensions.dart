import 'package:flutter/material.dart';

/// [ThemeExtension] template for custom text styles.
class AppTextThemeExtension extends ThemeExtension<AppTextThemeExtension> {
  /// Default constructor for the [AppTextThemeExtension]
  const AppTextThemeExtension({
    required this.exampleLargeTitle,
  });

  /// Navigation Large Title
  final TextStyle exampleLargeTitle;

  @override
  ThemeExtension<AppTextThemeExtension> copyWith({
    TextStyle? navTitle,
    TextStyle? navLargeTitle,
  }) {
    return AppTextThemeExtension(
      exampleLargeTitle: navLargeTitle ?? exampleLargeTitle,
    );
  }

  @override
  ThemeExtension<AppTextThemeExtension> lerp(
    covariant ThemeExtension<AppTextThemeExtension>? other,
    double t,
  ) {
    if (other is! AppTextThemeExtension) {
      return this;
    }

    return AppTextThemeExtension(
      exampleLargeTitle:
          TextStyle.lerp(exampleLargeTitle, other.exampleLargeTitle, t)!,
    );
  }
}
