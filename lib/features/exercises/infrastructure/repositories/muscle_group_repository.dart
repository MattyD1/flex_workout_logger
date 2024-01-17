import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/repositories/muscle_group_repository_interface.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/muscle_group_description.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/muscle_group_name.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/schema.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:realm/realm.dart';

/// Fully implemented repository for muscle groups
class MuscleGroupRepository implements IMuscleGroupRepository {
  /// Constructor
  MuscleGroupRepository({required this.realm});

  /// Realm instance
  final Realm realm;

  @override
  FutureOr<Either<Failure, MuscleGroupEntity>> createMuscleGroup(
    MuscleGroupName name,
    MuscleGroupDescription? description,
  ) {
    // TODO: implement createMuscleGroup
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, bool>> deleteMuscleGroup(String id) {
    // TODO: implement deleteMuscleGroup
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, MuscleGroupEntity>> getMuscleGroupById(String id) {
    // TODO: implement getMuscleGroupById
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, List<MuscleGroupEntity>>> getMuscleGroups() {
    try {
      final res = realm.all<MuscleGroup>();

      return right(
        res.map((e) => e.toEntity()).toList(),
      );
    } catch (e) {
      return left(
        Failure.internalServerError(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  FutureOr<Either<Failure, MuscleGroupEntity>> updateMuscleGroup(
    String? id,
    MuscleGroupName? name,
    MuscleGroupDescription? description,
  ) {
    // TODO: implement updateMuscleGroup
    throw UnimplementedError();
  }
}
