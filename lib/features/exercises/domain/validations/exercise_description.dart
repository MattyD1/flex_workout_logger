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
  if (input.length >= 1500) {
    return left(
      const Failure.unprocessableEntity(
        message: 'Exercise desciption must be less than 1500 characters.',
      ),
    );
  }

  return right(input);
}
