import 'package:flex_workout_logger/features/common/domain/errors/failure.dart';
import 'package:flex_workout_logger/features/common/domain/validations/validation_abstract.dart';
import 'package:fpdart/fpdart.dart';

/// Exercise Name Validation
class ExerciseStyle extends Validation<int> {
  /// Exercise Name Validation factory
  factory ExerciseStyle(int input) {
    return ExerciseStyle._(
      _validate(input),
    );
  }

  const ExerciseStyle._(this._value);

  @override
  Either<Failure, int> get value => _value;

  final Either<Failure, int> _value;
}

Either<Failure, int> _validate(int input) {
  if (input < 0 || input > 1) {
    return left(const Failure.unprocessableEntity(message: 'Invalid value.'));
  }

  return right(input);
}
