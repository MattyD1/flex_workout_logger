import 'package:flex_workout_logger/features/common/ui/utils/ui_extensions.dart';
import 'package:flex_workout_logger/features/common/ui/widgets/app_error.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_list_controller.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/exercise_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Exercises list on library screen
class ExercisesList extends ConsumerWidget {
  /// Constructor
  const ExercisesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercises = ref.watch(exercisesListControllerProvider);
    return exercises.when(
      data: (items) => items.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(8),
              child: Center(
                child: Text('No items found'),
              ),
            )
          : Column(
              children: [
                ...items.map(
                  (e) => Column(
                    children: [
                      ExercisesCard(
                        exercise: e,
                      ),
                      Divider(
                        color: context.colorScheme.divider,
                        height: 1,
                        indent: 64,
                      ),
                    ],
                  ),
                ),
              ],
            ),
      error: (o, e) => AppError(
        title: o.toString(),
      ),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
