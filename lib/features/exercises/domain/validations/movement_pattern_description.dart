import 'package:flex_workout_logger/utils/failure.dart';
import 'package:flex_workout_logger/utils/validation_abstract.dart';
import 'package:fpdart/fpdart.dart';

/// Movement Pattern Description value
class MovementPatternDescription extends Validation<String> {
  ///
  factory MovementPatternDescription(String input) {
    return MovementPatternDescription._(
      _validate(input),
    );
  }

  const MovementPatternDescription._(this._value);
  @override
  Either<Failure, String> get value => _value;

  final Either<Failure, String> _value;
}

Either<Failure, String> _validate(String input) {
  if (input.length > 250) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The description must be less than 250 characters in length',
      ),
    );
  }

  return right(input);
}
