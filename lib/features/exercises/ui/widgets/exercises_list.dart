import 'package:flex_workout_logger/features/common/ui/widgets/app_error.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_list_controller.dart';
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
                  (e) => ListTile(
                    title: Text(e.name),
                    onTap: () {/* Handle item tap */},
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
