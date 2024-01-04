import 'package:flex_workout_logger/features/common/domain/errors/failure.dart';
import 'package:flex_workout_logger/features/common/domain/validations/validation_abstract.dart';
import 'package:fpdart/fpdart.dart';

/// Exercise Name Validation
class MovementPatternName extends Validation<String> {
  /// Exercise Name Validation factory
  factory MovementPatternName(String input) {
    return MovementPatternName._(
      _validate(input),
    );
  }

  const MovementPatternName._(this._value);

  @override
  Either<Failure, String> get value => _value;

  final Either<Failure, String> _value;
}

Either<Failure, String> _validate(String input) {
  if (input.isEmpty) {
    return left(const Failure.empty());
  } else if (input.length >= 50) {
    return left(
      const Failure.unprocessableEntity(
        message: 'Movement Pattern name must be less than 50 characters.',
      ),
    );
  }

  return right(input);
}
