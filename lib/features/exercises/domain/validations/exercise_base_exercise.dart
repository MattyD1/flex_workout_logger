import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:flex_workout_logger/utils/validation_abstract.dart';
import 'package:fpdart/fpdart.dart';

/// Base exercise value
class ExerciseBaseExercise extends Validation<ExerciseEntity?> {
  ///
  factory ExerciseBaseExercise(
    ExerciseEntity? currentExercise,
    ExerciseEntity? baseExercise,
  ) {
    return ExerciseBaseExercise._(
      _validate(currentExercise, baseExercise),
    );
  }

  const ExerciseBaseExercise._(this._value);
  @override
  Either<Failure, ExerciseEntity?> get value => _value;

  final Either<Failure, ExerciseEntity?> _value;
}

Either<Failure, ExerciseEntity?> _validate(
  ExerciseEntity? currentExercise,
  ExerciseEntity? baseExercise,
) {
  if (baseExercise == null) {
    return right(null);
  }

  if (baseExercise.baseExercise != null) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The base exercise can not be a variation',
      ),
    );
  }

  // TODO: Fix: doesnt work as intended
  if (currentExercise?.id == baseExercise.id) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The base exercise can not be the same as the parent exercise',
      ),
    );
  }

  return right(baseExercise);
}
