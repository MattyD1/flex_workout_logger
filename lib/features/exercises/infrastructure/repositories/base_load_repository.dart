import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/base_load_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/load_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/repositories/base_load_repository_interface.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/base_load_assisted.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/base_load_body_weight.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/base_load_load.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/schema.dart';
import 'package:flex_workout_logger/utils/date_time_extensions.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:realm/realm.dart';

/// Fully implemented repository for movement patterns
class BaseLoadRepository implements IBaseLoadRepository {
  /// Constructor
  BaseLoadRepository({required this.realm});

  /// Realm instance
  final Realm realm;

  @override
  FutureOr<Either<Failure, BaseLoadEntity>> createBaseLoad(
    BaseLoadLoad load,
    BaseLoadAssisted assisted,
    BaseLoadBodyWeight bodyWeight,
  ) async {
    try {
      throw UnimplementedError();
    } catch (e) {
      return left(
        Failure.internalServerError(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  FutureOr<Either<Failure, bool>> deleteBaseLoad(String id) async {
    try {
      throw UnimplementedError();
    } catch (e) {
      return left(
        Failure.internalServerError(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  FutureOr<Either<Failure, int>> deleteMultipleBaseLoads(List<String> ids) async {
    try {
      throw UnimplementedError();
    } catch (e) {
      return left(
        Failure.internalServerError(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  FutureOr<Either<Failure, BaseLoadEntity>> getBaseLoadById(
    String id,
  ) async {
    try {
      throw UnimplementedError();
    } catch (e) {
      return left(
        Failure.internalServerError(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  FutureOr<Either<Failure, BaseLoadEntity>> updateBaseLoad(
    String id,
    BaseLoadLoad load,
    BaseLoadAssisted assisted,
    BaseLoadBodyWeight bodyWeight,
  ) async {
    try {
      throw UnimplementedError();
    } catch (e) {
      return left(
        Failure.internalServerError(
          message: e.toString(),
        ),
      );
    }
  }
}
