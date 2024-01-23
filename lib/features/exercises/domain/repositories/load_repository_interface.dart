import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/load_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/load_unit.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/load_weight.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

/// Load Repository Interface
abstract class ILoadRepository {
  /// Get Load by id
  FutureOr<Either<Failure, LoadEntity>> getLoadById(String id);

  /// Create Load
  FutureOr<Either<Failure, LoadEntity>> createLoad(
    LoadWeight weight,
    LoadUnit unit,
  );

  /// Update Load
  FutureOr<Either<Failure, LoadEntity>> updateLoad(
    String id,
    LoadWeight weight,
    LoadUnit unit,
  );

  /// Delete Load by id
  FutureOr<Either<Failure, bool>> deleteLoad(String id);

  /// Delete many Loads by id
  FutureOr<Either<Failure, int>> deleteMultipleLoads(List<String> ids);
}
