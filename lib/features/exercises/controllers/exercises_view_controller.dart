import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercises_view_controller.g.dart';

/// Exercises view controller
@riverpod
class ExercisesViewController extends _$ExercisesViewController {
  @override
  FutureOr<ExerciseEntity> build(String id) async {
    final res = await ref.watch(exerciseRepositoryProvider).getExerciseById(id);
    return res.fold((l) => throw l, (r) => r);
  }
}
