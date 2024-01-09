import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/repositories/exercise_repository_interface.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_description.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_name.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/schema.dart';
import 'package:flex_workout_logger/utils/date_time_extensions.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:realm/realm.dart';

/// Fully implemented repository for exercises
class ExerciseRepository implements IExerciseRepository {
  /// Constructor
  ExerciseRepository({required this.realm});

  /// Realm instance
  final Realm realm;

  @override
  FutureOr<Either<Failure, ExerciseEntity>> createExercise(
    ExerciseName name,
    ExerciseDescription description,
  ) async {
    try {
      final currentDateTime = DateTimeX.current;

      final exerciseToAdd = Exercise(
        ObjectId(),
        name.value.getOrElse((l) => 'No name provided'),
        description.value.getOrElse((l) => ''),
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
          message: e.toString(),
        ),
      );
    }
  }

  @override
  FutureOr<Either<Failure, bool>> deleteExercise(String id) async {
    try {
      final objectId = ObjectId.fromHexString(id);

      final res = realm.find<Exercise>(objectId);

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
  FutureOr<Either<Failure, int>> deleteMultipleExercises(
    List<String> ids,
  ) async {
    try {
      final objectIds = ids.map(ObjectId.fromHexString).toList();

      final res = realm.query<Exercise>('id IN \$0', [objectIds]);

      if (res.isEmpty) {
        return left(const Failure.empty());
      }

      final numberToDelete = res.length;

      realm.write(() {
        realm.deleteMany(res);
      });

      return right(numberToDelete);
    } catch (e) {
      return left(
        Failure.internalServerError(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  FutureOr<Either<Failure, ExerciseEntity>> getExerciseById(String id) async {
    try {
      final objectId = ObjectId.fromHexString(id);

      final res = realm.find<Exercise>(objectId);

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
  FutureOr<Either<Failure, List<ExerciseEntity>>> getExercises() async {
    try {
      final res = realm.all<Exercise>();

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
  FutureOr<Either<Failure, ExerciseEntity>> updateExercise(
    String id,
    ExerciseName name,
    ExerciseDescription description,
  ) async {
    try {
      final objectId = ObjectId.fromHexString(id);

      final res = realm.find<Exercise>(objectId);

      if (res == null) {
        return left(const Failure.empty());
      }

      final updatedExercise = Exercise(
        objectId,
        name.value.getOrElse((l) => 'No name provided'),
        description.value.getOrElse((l) => ''),
        res.createdAt,
        DateTimeX.current,
      );

      realm.write(() {
        realm.add(updatedExercise, update: true);
      });

      return right(updatedExercise.toEntity());
    } catch (e) {
      return left(
        Failure.internalServerError(
          message: e.toString(),
        ),
      );
    }
  }
}
