import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/muscle_group_description.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/muscle_group_name.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

/// MuscleGroup Repository Interface
abstract class IMuscleGroupRepository {
  /// Get MuscleGroup list
  FutureOr<Either<Failure, List<MuscleGroupEntity>>> getMuscleGroups();

  /// Get MuscleGroup by id
  FutureOr<Either<Failure, MuscleGroupEntity>> getMuscleGroupById(
    String id,
  );

  /// Create MuscleGroup
  FutureOr<Either<Failure, MuscleGroupEntity>> createMuscleGroup(
    MuscleGroupName name,
    MuscleGroupDescription? description,
  );

  /// Update MuscleGroup
  FutureOr<Either<Failure, MuscleGroupEntity>> updateMuscleGroup(
    String? id,
    MuscleGroupName? name,
    MuscleGroupDescription? description,
  );

  /// Delete MuscleGroup by id
  FutureOr<Either<Failure, bool>> deleteMuscleGroup(String id);
}
