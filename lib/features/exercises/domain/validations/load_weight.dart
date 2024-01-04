import 'package:flex_workout_logger/features/common/domain/errors/failure.dart';
import 'package:flex_workout_logger/features/common/domain/validations/validation_abstract.dart';
import 'package:fpdart/fpdart.dart';

const _maxDecimals = 2;

/// Exercise Name Validation
class ExerciseStyle extends Validation<double> {
  /// Exercise Name Validation factory
  factory ExerciseStyle(double input) {
    return ExerciseStyle._(
      _validate(input),
    );
  }

  const ExerciseStyle._(this._value);

  @override
  Either<Failure, double> get value => _value;

  final Either<Failure, double> _value;
}

Either<Failure, double> _validate(double input) {
  final cleanedInput = double.parse(input.toStringAsFixed(_maxDecimals));

  if (input == cleanedInput) {
    return left(
      const Failure.unprocessableEntity(
        message: 'Only $_maxDecimals decimals allowed.',
      ),
    );
  }

  return right(input);
}
