import 'package:flex_workout_logger/features/exercises/ui/widgets/exercises_list.dart';
import 'package:flutter/material.dart';

/// Library screen
class LibraryScreen extends StatelessWidget {
  /// Constructor
  const LibraryScreen({super.key});

  /// Route name
  static const routeName = 'library';

  /// Path name
  static const routePath = 'library';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ExercisesList(),
    );
  }
}
