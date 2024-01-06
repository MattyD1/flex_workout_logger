import 'dart:async';

import 'package:flex_workout_logger/features/common/domain/errors/failure.dart';
import 'package:flex_workout_logger/features/common/ui/utils/date_time_extensions.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/repositories/exercise_repository_interface.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_name.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/schema.dart';
import 'package:fpdart/fpdart.dart';
import 'package:realm/realm.dart';

/// Fully implemented repository for exercises
class ExerciseRepository implements IExerciseRepository {
  /// Constructor
  ExerciseRepository({required this.realm});

  /// Realm instance
  final Realm realm;

  @override
  FutureOr<Either<Failure, ExerciseEntity>> createDepartment(
    ExerciseName name,
  ) {
    try {
      final currentDateTime = DateTimeX.current;

      final exerciseToAdd = Exercise(
        ObjectId(),
        name.value.getOrElse((l) => 'No name provided'),
        currentDateTime,
        currentDateTime,
      );

      final res = realm.write<Exercise>(() {
        return realm.add(exerciseToAdd);
      });

      return right(res.toEntity());
    } catch (e) {
      return left(
        Failure.internalServerError(
          message: 'An internal server error has occured: $e',
        ),
      );
    }
  }

  @override
  FutureOr<Either<Failure, bool>> deleteDepartment(String id) {
    // TODO: implement deleteDepartment
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, bool>> deleteMultipleDepartments(List<String> ids) {
    // TODO: implement deleteMultipleDepartments
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, ExerciseEntity>> getDepartmentById(String id) {
    // TODO: implement getDepartmentById
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, List<ExerciseEntity>>> getDepartments() {
    // TODO: implement getDepartments
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, ExerciseEntity>> updateDepartment(
      String id, ExerciseName name) {
    // TODO: implement updateDepartment
    throw UnimplementedError();
  }
}
