import 'package:flex_workout_logger/features/exercises/domain/entities/load_entity.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:flex_workout_logger/utils/validation_abstract.dart';
import 'package:fpdart/fpdart.dart';

/// Base Load Load value
class BaseLoadLoad extends Validation<LoadEntity> {
  ///
  factory BaseLoadLoad(LoadEntity input) {
    return BaseLoadLoad._(
      _validate(input),
    );
  }

  const BaseLoadLoad._(this._value);
  @override
  Either<Failure, LoadEntity> get value => _value;

  final Either<Failure, LoadEntity> _value;
}

Either<Failure, LoadEntity> _validate(
  LoadEntity input,
) {
  return right(input);
}
