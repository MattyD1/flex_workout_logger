import 'package:flex_workout_logger/features/common/domain/errors/failure.dart';
import 'package:flex_workout_logger/features/common/domain/validations/validation_abstract.dart';
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
  if (input.length < 2) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The name must be at least 2 characters in length',
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
