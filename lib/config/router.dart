import 'package:flex_workout_logger/features/common/ui/screens/error_screen.dart';
import 'package:flex_workout_logger/features/common/ui/screens/test_realm_screen.dart';
import 'package:flex_workout_logger/features/common/ui/utils/ui_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Main router for the Example app
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const ExampleList(),
    ),
  ],
  observers: [
    routeObserver,
  ],
  debugLogDiagnostics: true,
  errorBuilder: (context, state) =>
      ErrorScreen(message: context.tr.somethingWentWrong),
);

/// Route observer to use with RouteAware
final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();
