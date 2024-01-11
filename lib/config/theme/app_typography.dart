import 'package:flutter/material.dart';

/// App Typography class
abstract class AppTypography {
  /// Large Title
  static const titleLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
  );

  /// Small Title
  static const titleSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  /// Headline Large
  static const headlineLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  /// Headline Small
  static const headlineSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  /// Body Medium
  static const bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  /// Body Small
  static const bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  /// List Title
  static const listTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  /// List Subtitle
  static const listSubtitle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}
