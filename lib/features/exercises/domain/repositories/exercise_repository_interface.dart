import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_base_exercise.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_description.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_engagement.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_movement_pattern.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_name.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_style.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

/// Exercise Repository Interface
abstract class IExerciseRepository {
  /// Get Exercise list
  FutureOr<Either<Failure, List<ExerciseEntity>>> getExercises();

  /// Get Exericse by id
  FutureOr<Either<Failure, ExerciseEntity>> getExerciseById(String id);

  /// Create Exercise
  FutureOr<Either<Failure, ExerciseEntity>> createExercise(
    ExerciseName name,
    ExerciseDescription description,
    ExerciseEngagement engagement,
    ExerciseStyle style,
    ExerciseBaseExercise? baseExercise,
    ExerciseMovementPattern? movementPattern,
  );

  /// Update Exercise
  FutureOr<Either<Failure, ExerciseEntity>> updateExercise(
    String id,
    ExerciseName name,
    ExerciseDescription description,
    ExerciseEngagement engagement,
    ExerciseStyle style,
    ExerciseBaseExercise? baseExercise,
    ExerciseMovementPattern? movementPattern,
  );

  /// Delete Exercise by id
  FutureOr<Either<Failure, bool>> deleteExercise(String id);

  /// Delete many Exercises by id
  FutureOr<Either<Failure, int>> deleteMultipleExercises(List<String> ids);
}
