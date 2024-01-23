import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/base_load_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/base_load_assisted.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/base_load_load.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

/// BaseLoad Repository Interface
abstract class IBaseLoadRepository {
  /// Get BaseLoad by id
  FutureOr<Either<Failure, BaseLoadEntity>> getBaseLoadById(String id);

  /// Create BaseLoad
  FutureOr<Either<Failure, BaseLoadEntity>> createBaseLoad(
    BaseLoadLoad load,
    BaseLoadAssisted assisted,
  );

  /// Update BaseLoad
  FutureOr<Either<Failure, BaseLoadEntity>> updateBaseLoad(
    String id,
    BaseLoadLoad load,
    BaseLoadAssisted assisted,
  );

  /// Delete BaseLoad by id
  FutureOr<Either<Failure, bool>> deleteBaseLoad(String id);

  /// Delete many Loads by id
  FutureOr<Either<Failure, int>> deleteMultipleBaseLoads(List<String> ids);
}
