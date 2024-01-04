import 'dart:async';

import 'package:flex_workout_logger/features/common/domain/errors/failure.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_coaching_cues.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_description.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_engagement.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_name.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/load_weight.dart';
import 'package:fpdart/fpdart.dart';

/// Abstract class for exercise repository
abstract class IExerciseRepository {
  /// Get all exercises
  FutureOr<Either<Failure, List<ExerciseEntity>>> getAllExercises();

  /// Get exercise by id
  FutureOr<Either<Failure, ExerciseEntity>> getExerciseById(String id);

  /// Quick Add Exercise
  FutureOr<Either<Failure, ExerciseEntity>> quickAddExercise(
    String name,
    String description,
    MovementPatternEntity movementPattern,
    List<MuscleGroupEntity> muscleGroups,
  );

  /// Add Exercise
  FutureOr<Either<Failure, ExerciseEntity>> addExercise(
    ExerciseName name,
    MovementPatternEntity movementPattern,
    List<MuscleGroupEntity> muscleGroups,
    ExerciseEngagement engagement,
    ExerciseStyle style,
    ExerciseEntity? parentExercise,
    ExerciseDescription? description,
    ExerciseCoachingCues? coachingCues,
    BaseLoad? baseWeight,
    Load? oneRepMax,
    Load? tenRepMax,
  );

  /// Update Exercise
  FutureOr<Either<Failure, ExerciseEntity>> updateExercise(
    ExerciseEntity exercise,
    ExerciseName name,
    MovementPatternEntity movementPattern,
    List<MuscleGroupEntity> muscleGroups,
    ExerciseEngagement engagement,
    ExerciseStyle style,
    ExerciseEntity? parentExercise,
    ExerciseDescription? description,
    ExerciseCoachingCues? coachingCues,
    BaseLoad? baseWeight,
    Load? oneRepMax,
    Load? tenRepMax,
  );

  /// Future Update 1RM
  Future<Either<Failure, ExerciseEntity>> updateOneRepMax(
    ExerciseEntity exercise,
    Load load,
  );

  /// Future Update 10RM
  Future<Either<Failure, ExerciseEntity>> updateTenRepMax(
    ExerciseEntity exercise,
    Load load,
  );

  /// Delete Exercise
  FutureOr<Either<Failure, void>> deleteExercise(String id);
}
