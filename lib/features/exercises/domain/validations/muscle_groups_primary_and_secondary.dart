import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group_entity.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:flex_workout_logger/utils/validation_abstract.dart';
import 'package:fpdart/fpdart.dart';

const MAX_ENTRIES = 2;
const MAX_MUSCLE_GROUPS = 5;

///
enum MuscleGroupPriority {
  ///
  primary,
  ///
  secondary,
}
const EMPTY_MUSCLE_GROUPS_MAP = {MuscleGroupPriority.primary: <MuscleGroupEntity>[], MuscleGroupPriority.secondary: <MuscleGroupEntity>[]};

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

  if(input == EMPTY_MUSCLE_GROUPS_MAP) {
    return right(input);
  }

  final primary = input.entries.firstWhere((entry) => entry.key == MuscleGroupPriority.primary).value;
  final secondary = input.entries.firstWhere((entry) => entry.key == MuscleGroupPriority.secondary).value;

  if (primary.isEmpty && secondary.isNotEmpty) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The exercise must have at least one primary muscle group, if any.',
      ),
    );
  }

  if (primary.length > MAX_MUSCLE_GROUPS || secondary.length > MAX_MUSCLE_GROUPS) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The exercise can only have 5 muscles groups per subgroup.',
      ),
    );
  }

  return right(input);
}