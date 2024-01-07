import 'package:flex_workout_logger/features/common/ui/utils/ui_extensions.dart';
import 'package:flex_workout_logger/features/common/ui/widgets/app_error.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_view_controller.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/exercise_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Exercises Detail View Screen
class ExercisesViewScreen extends ConsumerWidget {
  /// Constructor
  const ExercisesViewScreen({required this.id, super.key});

  /// Exercise id
  final String id;

  /// Route name
  static const routeName = 'exercises_view';

  /// Path name where eid is the id of the exercise
  static const routePath = 'exercises/:eid';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercise = ref.watch(exercisesViewControllerProvider(id));

    return Scaffold(
      backgroundColor: context.colorScheme.background,
      appBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.zero,
        backgroundColor: context.colorScheme.offBackground,
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
          color: context.colorScheme.foreground,
          iconSize: 29,
        ),
        middle: exercise.when(
          data: (data) => Text(
            data.name,
            style: TextStyle(color: context.colorScheme.foreground),
          ),
          error: (error, stackTrace) => const Text('Error'),
          loading: () => const Text(''),
        ),
      ),
      body: exercise.when(
        data: (data) => ExerciseView(exercise: data),
        error: (o, e) => AppError(
          title: o.toString(),
        ),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
