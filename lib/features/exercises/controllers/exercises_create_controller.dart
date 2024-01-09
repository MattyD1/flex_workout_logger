import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_description.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_name.dart';
import 'package:flex_workout_logger/features/exercises/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercises_create_controller.g.dart';

///
@riverpod
class ExercisesCreateController extends _$ExercisesCreateController {
  @override
  FutureOr<ExerciseEntity?> build() {
    return null;
  }

  ///
  Future<void> handle(
    ExerciseName name,
    ExerciseDescription description,
  ) async {
    state = const AsyncLoading();
    final res = await ref
        .read(exerciseRepositoryProvider)
        .createExercise(name, description);
    state = res.fold(
      (l) => AsyncValue.error(l.error, StackTrace.current),
      AsyncValue.data,
    );
  }
}
