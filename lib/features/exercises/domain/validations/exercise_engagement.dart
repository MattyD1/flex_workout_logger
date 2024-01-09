import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:flex_workout_logger/utils/validation_abstract.dart';
import 'package:fpdart/fpdart.dart';

/// Exercise Engagement value
class ExerciseEngagement extends Validation<Engagement> {
  ///
  factory ExerciseEngagement(Engagement input) {
    return ExerciseEngagement._(
      _validate(input),
    );
  }

  const ExerciseEngagement._(this._value);
  @override
  Either<Failure, Engagement> get value => _value;

  final Either<Failure, Engagement> _value;
}

Either<Failure, Engagement> _validate(Engagement input) {
  if (input.index.isNaN) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The exercise must have a type of engagment selected',
      ),
    );
  }
  
  if (input.index < 0 || input.index > 2) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The exercise must have a valid type of engagment selected',
      ),
    );
  }

  return right(input);
}
