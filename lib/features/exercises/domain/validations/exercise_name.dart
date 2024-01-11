import 'package:flex_workout_logger/utils/failure.dart';
import 'package:flex_workout_logger/utils/validation_abstract.dart';
import 'package:fpdart/fpdart.dart';

/// Department Name value
class ExerciseName extends Validation<String> {
  ///
  factory ExerciseName(String input) {
    return ExerciseName._(
      _validate(input),
    );
  }

  const ExerciseName._(this._value);
  @override
  Either<Failure, String> get value => _value;

  final Either<Failure, String> _value;
}

Either<Failure, String> _validate(String input) {
  if (input.isEmpty) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The exercise must have a name',
      ),
    );
  } else if (input.length > 100) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The name must be less than 100 characters in length',
      ),
    );
  }

  return right(input);
}
