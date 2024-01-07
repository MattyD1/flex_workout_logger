import 'package:flex_workout_logger/config/providers.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/repositories/exercise_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

///
/// Infrastructure dependencies
///

@riverpod
ExerciseRepository exerciseRepository(ExerciseRepositoryRef ref) {
  return ExerciseRepository(
    realm: ref.watch(realmClientProvider),
  );
}
