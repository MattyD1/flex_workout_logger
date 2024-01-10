import 'package:flutter/material.dart';

/// [ThemeExtension] template for custom text styles.
class AppTextThemeExtension extends ThemeExtension<AppTextThemeExtension> {
  /// Default constructor for the [AppTextThemeExtension]
  const AppTextThemeExtension({
    required this.listTitle,
    required this.listSubtitle,
  });

  /// List Title
  final TextStyle listTitle;

  /// Navigation Title
  final TextStyle listSubtitle;

  @override
  ThemeExtension<AppTextThemeExtension> copyWith({
    TextStyle? listTitle,
    TextStyle? listSubtitle,
  }) {
    return AppTextThemeExtension(
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
      listTitle: TextStyle.lerp(listTitle, other.listTitle, t)!,
      listSubtitle: TextStyle.lerp(listSubtitle, other.listSubtitle, t)!,
    );
  }
}
