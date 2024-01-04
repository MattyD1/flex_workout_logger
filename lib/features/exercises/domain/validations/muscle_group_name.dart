import 'package:flex_workout_logger/features/common/domain/errors/failure.dart';
import 'package:flex_workout_logger/features/common/domain/validations/validation_abstract.dart';
import 'package:fpdart/fpdart.dart';

/// Exercise Name Validation
class MuscleGroupName extends Validation<String> {
  /// Exercise Name Validation factory
  factory MuscleGroupName(String input) {
    return MuscleGroupName._(
      _validate(input),
    );
  }

  const MuscleGroupName._(this._value);

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
        message: 'Muscle Group name must be less than 50 characters.',
      ),
    );
  }

  return right(input);
}
