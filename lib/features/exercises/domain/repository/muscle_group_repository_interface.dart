import 'dart:async';
import 'package:flex_workout_logger/features/common/domain/errors/failure.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/muscle_group_name.dart';
import 'package:fpdart/fpdart.dart';

/// Abstract class for exercise repository
abstract class IMuscleGroupRepository {
  /// Get all muscle groups
  FutureOr<Either<Failure, List<MuscleGroupEntity>>> getAllMuscleGroups();

  /// Get muscle group by id
  FutureOr<Either<Failure, MuscleGroupEntity>> getMuscleGroupById(
    String id,
  );

  /// Get Exercsies by muscle group
  FutureOr<Either<Failure, List<ExerciseEntity>>> getExercisesByMuscleGroup(
    MuscleGroupEntity muscleGroup,
  );

  /// Add muscle group
  FutureOr<Either<Failure, MuscleGroupEntity>> addMuscleGroup(
    MuscleGroupName name,
  );

  /// Update muscle group
  FutureOr<Either<Failure, MuscleGroupEntity>> updateMuscleGroup(
    MuscleGroupEntity muscleGroup,
    MuscleGroupName name,
  );

  /// Delete muscle group
  FutureOr<Either<Failure, void>> deleteMuscleGroup(String id);
}
