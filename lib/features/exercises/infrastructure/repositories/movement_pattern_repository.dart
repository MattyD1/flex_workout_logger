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
  ) async {
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, bool>> deleteMovementPattern(String id) async {
    try {
      final objectId = ObjectId.fromHexString(id);

      final res = realm.find<MovementPattern>(objectId);

      if (res == null) {
        return left(const Failure.empty());
      }

      realm.write(() {
        realm.delete(res);
      });

      return right(true);
    } catch (e) {
      return left(
        Failure.internalServerError(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  FutureOr<Either<Failure, MovementPatternEntity>> getMovementPatternById(
    String id,
  ) async {
    try {
      final objectId = ObjectId.fromHexString(id);

      final res = realm.find<MovementPattern>(objectId);

      if (res == null) {
        return left(const Failure.empty());
      }

      return right(res.toEntity());
    } catch (e) {
      return left(
        Failure.internalServerError(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  FutureOr<Either<Failure, List<MovementPatternEntity>>>
      getMovementPatterns() async {
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
  ) async {
    throw UnimplementedError();
  }
}
