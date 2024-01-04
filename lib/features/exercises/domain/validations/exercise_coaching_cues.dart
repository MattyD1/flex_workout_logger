import 'package:flex_workout_logger/features/common/domain/errors/failure.dart';
import 'package:flex_workout_logger/features/common/domain/validations/validation_abstract.dart';
import 'package:fpdart/fpdart.dart';

/// Exercise CoachingCues Validation
class ExerciseCoachingCues extends Validation<List<String>> {
  /// Exercise CoachingCues Validation factory
  factory ExerciseCoachingCues(List<String> input) {
    return ExerciseCoachingCues._(
      _validate(input),
    );
  }

  const ExerciseCoachingCues._(this._value);

  @override
  Either<Failure, List<String>> get value => _value;

  final Either<Failure, List<String>> _value;
}

Either<Failure, List<String>> _validate(List<String> input) {
  if (input.length > 7) {
    return left(
      const Failure.unprocessableEntity(
        message: 'You can only have up to 7 coaching cues.',
      ),
    );
  }

  for (final coachingCue in input) {
    if (input.isEmpty) {
      return left(const Failure.empty());
    } else if (coachingCue.length >= 250) {
      return left(
        const Failure.unprocessableEntity(
          message: 'Each coaching cue must be less than 250 characters.',
        ),
      );
    }
  }

  return right(input);
}
