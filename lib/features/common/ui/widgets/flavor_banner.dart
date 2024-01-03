import 'package:flex_workout_logger/flavors.dart';
import 'package:flutter/material.dart';

/// Adds a banner to the top of the app to indicate the current flavor.
class FlavorBanner extends StatelessWidget {
  /// Creates a new [FlavorBanner].
  const FlavorBanner({required this.show, required this.child, super.key});

  /// Whether to show the banner.
  final bool show;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return show
        ? Banner(
            location: BannerLocation.topStart,
            message: F.flavor,
            color: Colors.green.withOpacity(0.6),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 8,
              letterSpacing: 1,
            ),
            textDirection: TextDirection.ltr,
            child: child,
          )
        : Container(
            child: child,
          );
  }
}
