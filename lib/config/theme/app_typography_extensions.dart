import 'package:flutter/material.dart';

/// [ThemeExtension] template for custom text styles.
class AppTextThemeExtension extends ThemeExtension<AppTextThemeExtension> {
  /// Default constructor for the [AppTextThemeExtension]
  const AppTextThemeExtension({
    // required this.displayLarge,
    // required this.displayMedium,
    // required this.displaySmall,
    required this.headlineLarge,
    // required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    // required this.titleMedium,
    required this.titleSmall,
    // required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.label,
    required this.listTitle,
    required this.listSubtitle,
  });

  // final TextStyle displayLarge;
  // final TextStyle displayMedium;
  // final TextStyle displaySmall;
  final TextStyle headlineLarge;
  // final TextStyle headlineMedium;
  final TextStyle headlineSmall;
  final TextStyle titleLarge;
  // final TextStyle titleMedium;
  final TextStyle titleSmall;
  // final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle label;

  /// List Title
  final TextStyle listTitle;

  /// Navigation Title
  final TextStyle listSubtitle;

  @override
  ThemeExtension<AppTextThemeExtension> copyWith({
    // TextStyle? displayLarge,
    // TextStyle? displayMedium,
    // TextStyle? displaySmall,
    TextStyle? headlineLarge,
    // TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    // TextStyle? titleMedium,
    TextStyle? titleSmall,
    // TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? label,
    TextStyle? listTitle,
    TextStyle? listSubtitle,
  }) {
    return AppTextThemeExtension(
      // displayLarge: displayLarge ?? this.displayLarge,
      // displayMedium: displayMedium ?? this.displayMedium,
      // displaySmall: displaySmall ?? this.displaySmall,
      headlineLarge: headlineLarge ?? this.headlineLarge,
      // headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      // titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      // bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      label: label ?? this.label,
      listTitle: listTitle ?? this.listTitle,
      listSubtitle: listSubtitle ?? this.listSubtitle,
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
      // displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t)!,
      // displayMedium: TextStyle.lerp(displayMedium, other.displayMedium, t)!,
      // displaySmall: TextStyle.lerp(displaySmall, other.displaySmall, t)!,
      headlineLarge: TextStyle.lerp(headlineLarge, other.headlineLarge, t)!,
      // headlineMedium: TextStyle.lerp(headlineMedium, other.headlineMedium, t)!,
      headlineSmall: TextStyle.lerp(headlineSmall, other.headlineSmall, t)!,
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t)!,
      // titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t)!,
      // bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      label: TextStyle.lerp(label, other.label, t)!,
      listTitle: TextStyle.lerp(listTitle, other.listTitle, t)!,
      listSubtitle: TextStyle.lerp(listSubtitle, other.listSubtitle, t)!,
    );
  }
}
