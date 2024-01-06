import 'package:flex_workout_logger/features/common/domain/errors/failure.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_name.dart';
import 'package:fpdart/fpdart.dart';

/// Exercise Repository Interface
abstract class IExerciseRepository {
  /// Get Exercise list
  Future<Either<Failure, List<ExerciseEntity>>> getDepartments();

  /// Get Exericse by id
  Future<Either<Failure, ExerciseEntity>> getDepartmentById(String id);

  /// Create Exercise
  Future<Either<Failure, ExerciseEntity>> createDepartment(
    ExerciseName name,
  );

  /// Update Exercise
  Future<Either<Failure, ExerciseEntity>> updateDepartment(
    String id,
    ExerciseName name,
  );

  /// Delete Exercise by id
  Future<Either<Failure, bool>> deleteDepartment(String id);

  /// Delete many Exercises by id
  Future<Either<Failure, bool>> deleteMultipleDepartments(List<String> ids);
}
