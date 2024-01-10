import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:flex_workout_logger/utils/validation_abstract.dart';
import 'package:fpdart/fpdart.dart';

/// Exercise Style value
class ExerciseStyle extends Validation<Style> {
  ///
  factory ExerciseStyle(Style input) {
    return ExerciseStyle._(
      _validate(input),
    );
  }

  const ExerciseStyle._(this._value);
  @override
  Either<Failure, Style> get value => _value;

  final Either<Failure, Style> _value;
}

Either<Failure, Style> _validate(Style input) {
  if (input.index.isNaN) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The exercise must have a type of style selected',
      ),
    );
  }
  
  if (input.index < 0 || input.index > 1) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The exercise must have a valid type of style selected',
      ),
    );
  }

  return right(input);
}
