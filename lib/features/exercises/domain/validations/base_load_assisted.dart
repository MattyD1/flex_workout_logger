import 'package:flex_workout_logger/utils/failure.dart';
import 'package:flex_workout_logger/utils/validation_abstract.dart';
import 'package:fpdart/fpdart.dart';

/// Base Load Assisted value
class BaseLoadAssisted extends Validation<bool> {
  ///
  factory BaseLoadAssisted(bool input) {
    return BaseLoadAssisted._(
      _validate(input),
    );
  }

  const BaseLoadAssisted._(this._value);
  @override
  Either<Failure, bool> get value => _value;

  final Either<Failure, bool> _value;
}

Either<Failure, bool> _validate(
  bool input,
) {
  return right(input);
}
