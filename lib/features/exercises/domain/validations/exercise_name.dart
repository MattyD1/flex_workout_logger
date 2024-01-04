import 'package:flex_workout_logger/features/common/domain/errors/failure.dart';
import 'package:flex_workout_logger/features/common/domain/validations/validation_abstract.dart';
import 'package:fpdart/fpdart.dart';

/// Exercise Name Validation
class ExerciseName extends Validation<String> {
  /// Exercise Name Validation factory
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
    return left(const Failure.empty());
  } else if (input.length >= 100) {
    return left(
      const Failure.unprocessableEntity(
        message: 'Exercise name must be less than 100 characters.',
      ),
    );
  }

  return right(input);
}
