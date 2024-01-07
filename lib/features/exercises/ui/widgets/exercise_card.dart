import 'package:flex_workout_logger/features/common/ui/utils/ui_extensions.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flutter/cupertino.dart';

/// A selectable card with [Exercise Title]
class ExercisesCard extends StatelessWidget {
  ///
  const ExercisesCard({required this.exercise, super.key});

  /// The exercise the card represents
  final ExerciseEntity exercise;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Text(
        exercise.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,

        // TODO make this into a text style
        style: TextStyle(
          fontSize: 16,
          color: context.colorScheme.foreground,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: const Icon(CupertinoIcons.square),
      padding: const EdgeInsets.fromLTRB(
        20,
        14,
        14,
        14,
      ),
    );
  }
}
