import 'dart:async';
import 'package:flex_workout_logger/features/common/domain/errors/failure.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/movement_pattern_name.dart';
import 'package:fpdart/fpdart.dart';

/// Abstract class for exercise repository
abstract class IMovementPatternRepository {
  /// Get all movement patterns
  FutureOr<Either<Failure, List<MovementPatternEntity>>>
      getAllMovementPatterns();

  /// Get movement pattern by id
  FutureOr<Either<Failure, MovementPatternEntity>> getMovementPatternById(
    String id,
  );

  /// Get Exercsies by Movement Pattern
  FutureOr<Either<Failure, List<ExerciseEntity>>> getExercisesByMovementPattern(
    MovementPatternEntity movementPattern,
  );

  /// Add Movement Pattern
  FutureOr<Either<Failure, MovementPatternEntity>> addMovementPattern(
    MovementPatternName name,
  );

  /// Update Movement Pattern
  FutureOr<Either<Failure, MovementPatternEntity>> updateMovementPattern(
    MovementPatternEntity movementPattern,
    MovementPatternName name,
  );

  /// Delete muscle group
  FutureOr<Either<Failure, void>> deleteMovementPattern(String id);
}
