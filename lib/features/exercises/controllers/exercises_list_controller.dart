import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercises_list_controller.g.dart';

/// Controller for the exercises list
@riverpod
class ExercisesListController extends _$ExercisesListController {
  @override
  FutureOr<List<ExerciseEntity>> build() async {
    final res = await ref.watch(exerciseRepositoryProvider).getExercises();
    return res.fold((l) => throw l, (r) => r);
  }
}
