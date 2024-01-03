import 'package:flex_workout_logger/config/router.dart';
import 'package:flex_workout_logger/flavors.dart';
import 'package:flex_workout_logger/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// The main application widget.
class App extends StatelessWidget {
  /// Creates a new [App].
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: F.title,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
