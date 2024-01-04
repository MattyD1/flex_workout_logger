import 'package:flex_workout_logger/features/common/domain/errors/failure.dart';
import 'package:flex_workout_logger/features/common/domain/validations/validation_abstract.dart';
import 'package:fpdart/fpdart.dart';

/// Exercise Description Validation
class ExerciseDescription extends Validation<String> {
  /// Exercise Description Validation factory
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
