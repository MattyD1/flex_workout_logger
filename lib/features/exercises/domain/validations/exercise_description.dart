import 'package:flex_workout_logger/utils/failure.dart';
import 'package:flex_workout_logger/utils/validation_abstract.dart';
import 'package:fpdart/fpdart.dart';

/// Department Name value
class ExerciseDescription extends Validation<String> {
  ///
  factory ExerciseDescription(String input) {
    return ExerciseDescription._(
      _validate(input),
    );
  }

  const ExerciseDescription._(this._value);
  @override
  Either<Failure, String> get value => _value;

  final Either<Failure, String> _value;
}

Either<Failure, String> _validate(String input) {
  if (input.length > 1500) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The description must be less than 1500 characters in length',
      ),
    );
  }

  return right(input);
}
