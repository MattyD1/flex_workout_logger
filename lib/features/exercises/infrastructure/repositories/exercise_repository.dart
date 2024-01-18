// ignore_for_file: use_raw_strings

import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/repositories/exercise_repository_interface.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_base_exercise.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_description.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_engagement.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_movement_pattern.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_muscle_groups.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_name.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_style.dart';
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
    ExerciseDescription? description,
    ExerciseEngagement engagement,
    ExerciseStyle style,
    ExerciseBaseExercise? baseExercise,
    ExerciseMovementPattern? movementPattern,
    ExerciseMuscleGroups muscleGroups,
  ) async {
    try {
      final currentDateTime = DateTimeX.current;
      final name_ = name.value.getOrElse((l) => 'No name provided');
      final description_ = description?.value.getOrElse((l) => '');
      final engagement_ =
          engagement.value.getOrElse((l) => Engagement.bilateral);
      final style_ = style.value.getOrElse((l) => Style.reps);

      final baseExercise_ = baseExercise?.value.getOrElse((l) => null);
      // ignore: avoid_init_to_null
      late Exercise? baseExerciseRes_ =
          null; // Init to null to avoid initialization error

      if (baseExercise_ != null) {
        final objectId = ObjectId.fromHexString(baseExercise_.id);

        baseExerciseRes_ = realm.find<Exercise>(objectId);

        if (baseExerciseRes_ == null) {
          return left(const Failure.empty());
        }
      }

      final movementPattern_ = movementPattern?.value.getOrElse((l) => null);
      // ignore: avoid_init_to_null
      late MovementPattern? movementPatternRes_ = null;

      if (movementPattern_ != null) {
        final objectId = ObjectId.fromHexString(movementPattern_.id);

        movementPatternRes_ = realm.find<MovementPattern>(objectId);

        if (movementPatternRes_ == null) {
          return left(const Failure.empty());
        }
      }

      final muscleGroups_ = muscleGroups.value.getOrElse((l) => []);
      final muscleGroupIds =
          muscleGroups_.map((e) => ObjectId.fromHexString(e.id)).toList();
      final muscleGroupsRes_ =
          realm.query<MuscleGroup>('id IN \$0', [muscleGroupIds]);

      final exerciseToAdd = Exercise(
        ObjectId(),
        name_,
        description_ ?? '',
        engagement_.index,
        style_.index,
        currentDateTime,
        currentDateTime,
      )
        ..baseExercise = baseExerciseRes_
        ..movementPattern = movementPatternRes_;

      final res = realm.write<Exercise>(() {
        // Add muscle groups to exercise
        exerciseToAdd.primaryMuscleGroups.addAll(muscleGroupsRes_);

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
    ExerciseEngagement engagement,
    ExerciseStyle style,
    ExerciseBaseExercise? baseExercise,
    ExerciseMovementPattern? movementPattern,
  ) async {
    try {
      final objectId = ObjectId.fromHexString(id);

      final res = realm.find<Exercise>(objectId);

      if (res == null) {
        return left(const Failure.empty());
      }

      final name_ = name.value.getOrElse((l) => 'No name provided');
      final description_ = description.value.getOrElse((l) => res.description);
      final engagement_ = engagement.value.getOrElse((l) => res.engagement);
      final style_ = style.value.getOrElse((l) => res.style);
      final baseExercise_ = baseExercise?.value.getOrElse((l) => null);
      final movementPattern_ = movementPattern?.value.getOrElse((l) => null);

      // ignore: avoid_init_to_null
      late Exercise? baseExerciseRes_ =
          null; // Init to null to avoid initialization error

      if (baseExercise_ != null) {
        final objectId = ObjectId.fromHexString(baseExercise_.id);

        baseExerciseRes_ = realm.find<Exercise>(objectId);

        if (baseExerciseRes_ == null) {
          return left(const Failure.empty());
        }
      }

      // ignore: avoid_init_to_null
      late MovementPattern? movementPatternRes_ = null;

      if (movementPattern_ != null) {
        final objectId = ObjectId.fromHexString(movementPattern_.id);

        movementPatternRes_ = realm.find<MovementPattern>(objectId);

        if (movementPatternRes_ == null) {
          return left(const Failure.empty());
        }
      }

      final updatedExercise = Exercise(
        objectId,
        name_,
        description_,
        engagement_.index,
        style_.index,
        res.createdAt,
        DateTimeX.current,
      )
        ..baseExercise = baseExerciseRes_ ?? res.baseExercise
        ..movementPattern = movementPatternRes_ ?? res.movementPattern;

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
