import 'package:flex_workout_logger/features/common/domain/errors/failure.dart';
import 'package:flex_workout_logger/features/common/domain/validations/validation_abstract.dart';
import 'package:fpdart/fpdart.dart';

/// Exercise Engagement Validation
class ExerciseEngagement extends Validation<int> {
  /// Exercise Engagement Validation factory
  factory ExerciseEngagement(int input) {
    return ExerciseEngagement._(
      _validate(input),
    );
  }

  const ExerciseEngagement._(this._value);

  @override
  Either<Failure, int> get value => _value;

  final Either<Failure, int> _value;
}

Either<Failure, int> _validate(int input) {
  if (input < 0 || input > 2) {
    return left(const Failure.unprocessableEntity(message: 'Invalid value.'));
  }

  return right(input);
}
