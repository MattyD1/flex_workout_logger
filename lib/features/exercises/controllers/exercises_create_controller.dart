import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_base_exercise.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_description.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_engagement.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_movement_pattern.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_muscle_groups.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_name.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_style.dart';
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
    // Map<MuscleGroupEnum, ExerciseMuscleGroups> muscleGroups,
  ) async {
    state = const AsyncLoading();

    ///  {
    ///     KEY: MuscleGroupEnum.primary,
    ///     VALUE: ExerciseMuscleGroups([])
    ///  },
    ///
    ///
    ///   {
    ///    KEY: MuscleGroupEnum.secondary,
    ///   VALUE: MuscleGroup([])
    ///
    ///  }

    /// Translate from map to two muscle group lists
    // final primaryMuscleGroups = muscleGroups.entries
    //     .where((element) => element.key == MuscleGroupEnum.primary)
    //     .first
    //     .value;

    // final secondaryMuscleGroups = muscleGroups.entries
    //     .where((element) => element.key == MuscleGroupEnum.secondary)
    //     .first
    //     .value;

    final res = await ref.read(exerciseRepositoryProvider).createExercise(
          name,
          description,
          engagement,
          style,
          baseExercise,
          movementPattern,
          ExerciseMuscleGroups([]),
          ExerciseMuscleGroups([]),
        );
    state = res.fold(
      (l) => AsyncValue.error(l.error, StackTrace.current),
      AsyncValue.data,
    );
  }
}

/// Muscle group enum
enum MuscleGroupEnum {
  /// Identifies primary muscle groups in a movement
  primary,

  /// Identifies secondary muscle groups in a movement
  secondary
}
