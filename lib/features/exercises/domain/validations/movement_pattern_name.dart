import 'package:flex_workout_logger/utils/failure.dart';
import 'package:flex_workout_logger/utils/validation_abstract.dart';
import 'package:fpdart/fpdart.dart';

/// Department Name value
class MovementPatternName extends Validation<String> {
  ///
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
    return left(
      const Failure.unprocessableEntity(
        message: 'The movement pattern must have a name',
      ),
    );
  } else if (input.length > 50) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The name must be less than 50 characters in length',
      ),
    );
  }

  return right(input);
}
