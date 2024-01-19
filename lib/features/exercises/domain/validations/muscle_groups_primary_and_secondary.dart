import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group_entity.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:flex_workout_logger/utils/validation_abstract.dart';
import 'package:fpdart/fpdart.dart';

const MAX_ENTRIES = 2;
const MAX_MUSCLE_GROUPS = 5;

/// Exercise Movement Pattern value
class MuscleGroupsPrimaryAndSecondary extends Validation<Map<MuscleGroupPriority, List<MuscleGroupEntity>>> {
  ///
  factory MuscleGroupsPrimaryAndSecondary(Map<MuscleGroupPriority, List<MuscleGroupEntity>> input) {
    return MuscleGroupsPrimaryAndSecondary._(
      _validate(input),
    );
  }

  const MuscleGroupsPrimaryAndSecondary._(this._value);
  @override
  Either<Failure, Map<MuscleGroupPriority, List<MuscleGroupEntity>>> get value => _value;

  final Either<Failure, Map<MuscleGroupPriority, List<MuscleGroupEntity>>> _value;
}

Either<Failure, Map<MuscleGroupPriority, List<MuscleGroupEntity>>> _validate(
  Map<MuscleGroupPriority, List<MuscleGroupEntity>> input,
) {

  if (input.entries.length != MAX_ENTRIES) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The exercise can only have two muscle subgroups.',
      ),
    );
  }

  if (input.entries.first.value.isEmpty && input.entries.last.value.isNotEmpty) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The exercise must have at least one primary muscle group, if any.',
      ),
    );
  }

  if (input.entries.first.value.length > MAX_MUSCLE_GROUPS || input.entries.last.value.length > MAX_MUSCLE_GROUPS) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The exercise can only have 5 muscles groups per subgroup.',
      ),
    );
  }

  return right(input);
}

///
enum MuscleGroupPriority {
  primary,
  secondary,
}