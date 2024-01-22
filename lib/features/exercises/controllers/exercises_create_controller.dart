import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_base_exercise.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_description.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_engagement.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_movement_pattern.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_muscle_groups.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_name.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_style.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/muscle_groups_primary_and_secondary.dart';
import 'package:flex_workout_logger/features/exercises/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercises_create_controller.g.dart';

///
@riverpod
class ExercisesCreateController extends _$ExercisesCreateController {
  @override
  FutureOr<ExerciseEntity?> build() {
    return null;
  }

  ///
  Future<void> handle(
    ExerciseName name,
    ExerciseDescription? description,
    ExerciseEngagement engagement,
    ExerciseStyle style,
    ExerciseBaseExercise? baseExercise,
    ExerciseMovementPattern movementPattern,
    MuscleGroupsPrimaryAndSecondary muscleGroups,
  ) async {
    state = const AsyncLoading();

    final primaryMuscleGroups = ExerciseMuscleGroups(muscleGroups.value.getOrElse((l) => EMPTY_MUSCLE_GROUPS_MAP).entries.firstWhere((entry) => entry.key == MuscleGroupPriority.primary).value);
    final secondaryMuscleGroups = ExerciseMuscleGroups(muscleGroups.value.getOrElse((l) => EMPTY_MUSCLE_GROUPS_MAP).entries.firstWhere((entry) => entry.key == MuscleGroupPriority.secondary).value);

    final res = await ref.read(exerciseRepositoryProvider).createExercise(
          name,
          description,
          engagement,
          style,
          baseExercise,
          movementPattern,
          primaryMuscleGroups,
          secondaryMuscleGroups,
        );
    state = res.fold(
      (l) => AsyncValue.error(l.error, StackTrace.current),
      AsyncValue.data,
    );
  }
}
