import 'package:flex_workout_logger/features/common/ui/screen/test_realm_screen.dart';
import 'package:flex_workout_logger/features/common/ui/widgets/flavor_banner.dart';
import 'package:flex_workout_logger/flavors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// The main application widget.
class App extends StatelessWidget {
  /// Creates a new [App].
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: F.title,
      home: const FlavorBanner(
        show: kDebugMode,
        child: Scaffold(
          body: Center(child: ExampleList()),
        ),
      ),
    );
  }
}
