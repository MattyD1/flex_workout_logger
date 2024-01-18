import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group_entity.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:flex_workout_logger/utils/validation_abstract.dart';
import 'package:fpdart/fpdart.dart';

/// Exercise Movement Pattern value
class ExerciseMuscleGroups extends Validation<List<MuscleGroupEntity>> {
  ///
  factory ExerciseMuscleGroups(List<MuscleGroupEntity> input) {
    return ExerciseMuscleGroups._(
      _validate(input),
    );
  }

  const ExerciseMuscleGroups._(this._value);
  @override
  Either<Failure, List<MuscleGroupEntity>> get value => _value;

  final Either<Failure, List<MuscleGroupEntity>> _value;
}

Either<Failure, List<MuscleGroupEntity>> _validate(
  List<MuscleGroupEntity> input,
) {
  if (input.length > 5) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The exercise must have no more than 5 muscle groups.',
      ),
    );
  }

  return right(input);
}
