import 'package:flex_workout_logger/features/exercises/domain/entities/load_entity.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:flex_workout_logger/utils/validation_abstract.dart';
import 'package:fpdart/fpdart.dart';

/// Load Style value
class LoadUnit extends Validation<WeightUnit> {
  ///
  factory LoadUnit(WeightUnit input) {
    return LoadUnit._(
      _validate(input),
    );
  }

  const LoadUnit._(this._value);
  @override
  Either<Failure, WeightUnit> get value => _value;

  final Either<Failure, WeightUnit> _value;
}

Either<Failure, WeightUnit> _validate(WeightUnit input) {
  if (input.index.isNaN) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The load must have a type of weight unit selected',
      ),
    );
  }
  
  if (input.index < 0 || input.index > 1) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The load must have a valid type of weight unit selected',
      ),
    );
  }

  return right(input);
}
