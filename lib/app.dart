import 'package:flex_workout_logger/config/router.dart';
import 'package:flex_workout_logger/config/theme/theme.dart';
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

      // Themeing
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,

      // Localization
      localizationsDelegates: AppLocalizations.localizationsDelegates,

      // Remove debug banner in the top right corner
      debugShowCheckedModeBanner: false,

      // Router
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
