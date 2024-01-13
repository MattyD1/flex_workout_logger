import 'package:flex_workout_logger/config/routing/error_screen.dart';
import 'package:flex_workout_logger/features/exercises/ui/screens/exercises_create_screen.dart';
import 'package:flex_workout_logger/features/exercises/ui/screens/exercises_edit_screen.dart';
import 'package:flex_workout_logger/features/exercises/ui/screens/exercises_view_screen.dart';
import 'package:flex_workout_logger/features/exercises/ui/screens/movement_pattern_list_screen.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Main router for the Example app
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: MovementPatternListScreen.routeName,
      builder: (context, state) => const MovementPatternListScreen(),
      routes: [
        GoRoute(
          path: ExercisesCreateScreen.routePath,
          name: ExercisesCreateScreen.routeName,
          builder: (context, state) => const ExercisesCreateScreen(),
        ),
        GoRoute(
          path: ExercisesViewScreen.routePath,
          name: ExercisesViewScreen.routeName,
          builder: (context, state) => ExercisesViewScreen(
            id: state.pathParameters['eid']!,
          ),
        ),
        GoRoute(
          path: ExercisesEditScreen.routePath,
          name: ExercisesEditScreen.routeName,
          builder: (context, state) => ExercisesEditScreen(
            id: state.pathParameters['eid']!,
          ),
        ),
      ],
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
