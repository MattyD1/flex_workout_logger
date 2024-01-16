import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/movement_pattern_description.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/movement_pattern_name.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

/// MovementPattern Repository Interface
abstract class IMovementPatternRepository {
  /// Get MovementPattern list
  FutureOr<Either<Failure, List<MovementPatternEntity>>> getMovementPatterns();

  /// Get MovementPattern by id
  FutureOr<Either<Failure, MovementPatternEntity>> getMovementPatternById(
    String id,
  );

  /// Create MovementPattern
  FutureOr<Either<Failure, MovementPatternEntity>> createMovementPattern(
    MovementPatternName name,
    MovementPatternDescription description,
  );

  /// Update MovementPattern
  FutureOr<Either<Failure, MovementPatternEntity>> updateMovementPattern(
    String? id,
    MovementPatternName? name,
    MovementPatternDescription? description,
  );

  /// Delete MovementPattern by id
  FutureOr<Either<Failure, bool>> deleteMovementPattern(String id);
}
