import 'package:flex_workout_logger/config/providers.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/repositories/exercise_repository.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/repositories/movement_pattern_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

///
/// Infrastructure dependencies
///

/// Exercise repository provider
@riverpod
ExerciseRepository exerciseRepository(ExerciseRepositoryRef ref) {
  return ExerciseRepository(
    realm: ref.watch(realmClientProvider),
  );
}

/// Movement pattern repository provider
@riverpod
MovementPatternRepository movementPatternRepository(
  MovementPatternRepositoryRef ref,
) {
  return MovementPatternRepository(
    realm: ref.watch(realmClientProvider),
  );
}
