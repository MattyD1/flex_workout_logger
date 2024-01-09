import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

/// Provides specifications for value objects.
abstract class Validation<T> {
  ///
  const Validation();

  /// Getter
  Either<Failure, T> get value;

  @override
  String toString() => value.fold((l) => l.error, (r) => r.toString());

  /// Form valid handler
  String? get validate => value.fold((l) => l.error, (r) => null);
}
