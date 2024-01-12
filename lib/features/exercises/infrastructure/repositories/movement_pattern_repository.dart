import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/repositories/movement_pattern_interface.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/movement_pattern_description.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/movement_pattern_name.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/schema.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:realm/realm.dart';

/// Fully implemented repository for movement patterns
class MovementPatternRepository implements IMovementPatternRepository {
  /// Constructor
  MovementPatternRepository({required this.realm});

  /// Realm instance
  final Realm realm;

  @override
  FutureOr<Either<Failure, MovementPatternEntity>> createMovementPattern(
    MovementPatternName name,
    MovementPatternDescription description,
  ) {
    // TODO: implement createMovementPattern
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, bool>> deleteMovementPattern(String id) {
    // TODO: implement deleteMovementPattern
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, MovementPatternEntity>> getMovementPatternById(
    String id,
  ) {
    // TODO: implement getMovementPatternById
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, List<MovementPatternEntity>>> getMovementPatterns() {
    try {
      final res = realm.all<MovementPattern>();

      return right(res.map((e) => e.toEntity()).toList());
    } catch (e) {
      return left(
        Failure.internalServerError(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  FutureOr<Either<Failure, MovementPatternEntity>> updateMovementPattern(
    String id,
    MovementPatternName name,
    MovementPatternDescription description,
  ) {
    // TODO: implement updateMovementPattern
    throw UnimplementedError();
  }
}
