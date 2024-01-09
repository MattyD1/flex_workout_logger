import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flutter/widgets.dart';

/// The detail view of an exercise
class ExerciseView extends StatelessWidget {
  ///
  const ExerciseView({required this.exercise, super.key});

  /// The exercise the card represents
  final ExerciseEntity exercise;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(exercise.name),
        Text(exercise.description),
        Text(exercise.createdAt.toIso8601String()),
        Text(exercise.updatedAt.toIso8601String()),
      ],
    );
  }
}
