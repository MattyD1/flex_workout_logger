import 'package:flex_workout_logger/utils/failure.dart';
import 'package:flex_workout_logger/utils/validation_abstract.dart';
import 'package:fpdart/fpdart.dart';

const MIN_WEIGHT = -9999.0;
const MAX_WEIGHT = 9999.0;

/// Load Weight value
class LoadWeight extends Validation<double> {
  ///
  factory LoadWeight(double input) {
    return LoadWeight._(
      _validate(input),
    );
  }

  const LoadWeight._(this._value);
  @override
  Either<Failure, double> get value => _value;

  final Either<Failure, double> _value;
}

Either<Failure, double> _validate(double input) {
  if (input.isNaN) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The load must have a weight as a number or decimal.',
      ),
    );
  }
  
  if (input < MIN_WEIGHT || input > MAX_WEIGHT) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The load must have a valid number between $MIN_WEIGHT and $MAX_WEIGHT.',
      ),
    );
  }

  return right(input);
}
