import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/load_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/repositories/load_repository_interface.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/load_weight.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/load_unit.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/schema.dart';
import 'package:flex_workout_logger/utils/date_time_extensions.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:realm/realm.dart';

/// Fully implemented repository for movement patterns
class LoadRepository implements ILoadRepository {
  /// Constructor
  LoadRepository({required this.realm});

  /// Realm instance
  final Realm realm;

  @override
  FutureOr<Either<Failure, LoadEntity>> createLoad(
    LoadWeight weight,
    LoadUnit unit,
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
  FutureOr<Either<Failure, bool>> deleteLoad(String id) async {
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
  FutureOr<Either<Failure, LoadEntity>> getLoadById(
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
  FutureOr<Either<Failure, LoadEntity>> updateLoad(
    String? id,
    LoadWeight? weight,
    LoadUnit? unit,
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
