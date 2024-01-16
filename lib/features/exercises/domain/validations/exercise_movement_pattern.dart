import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern_entity.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:flex_workout_logger/utils/validation_abstract.dart';
import 'package:fpdart/fpdart.dart';

/// Exercise Movement Pattern value
class ExerciseMovementPattern extends Validation<MovementPatternEntity?> {
  ///
  factory ExerciseMovementPattern(MovementPatternEntity? input) {
    return ExerciseMovementPattern._(
      _validate(input),
    );
  }

  const ExerciseMovementPattern._(this._value);
  @override
  Either<Failure, MovementPatternEntity?> get value => _value;

  final Either<Failure, MovementPatternEntity?> _value;
}

Either<Failure, MovementPatternEntity?> _validate(
  MovementPatternEntity? input,
) {
  return right(input);
}
