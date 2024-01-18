import 'dart:async';

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

part 'exercises_edit_controller.g.dart';

///
@riverpod
class ExercisesEditController extends _$ExercisesEditController {
  @override
  FutureOr<ExerciseEntity> build(String id) async {
    final res = await ref.watch(exerciseRepositoryProvider).getExerciseById(id);

    return res.fold((l) => throw l, (r) => r);
  }

  ///
  Future<void> handle(
    ExerciseName name,
    ExerciseDescription description,
    ExerciseEngagement engagement,
    ExerciseStyle style,
    ExerciseBaseExercise? baseExercise,
    ExerciseMovementPattern? movementPattern,
    ExerciseMuscleGroups muscleGroups,
  ) async {
    state = const AsyncLoading();
    final res = await ref.read(exerciseRepositoryProvider).updateExercise(
          id,
          name,
          description,
          engagement,
          style,
          baseExercise,
          movementPattern,
          muscleGroups,
        );

    state = res.fold(
      (l) => AsyncValue.error(l.error, StackTrace.current),
      AsyncValue.data,
    );
  }
}
