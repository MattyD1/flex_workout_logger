import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_name.dart';
import 'package:flex_workout_logger/features/exercises/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercises_edit_controller.g.dart';

///
@riverpod
class ExercisesEditController extends _$ExercisesEditController {
  @override
  FutureOr<ExerciseEntity?> build(String id) {
    return null;
  }

  ///
  Future<void> handle(ExerciseName name) async {
    state = const AsyncLoading();
    final res =
        await ref.read(exerciseRepositoryProvider).updateExercise(id, name);

    state = res.fold(
      (l) => AsyncValue.error(l.error, StackTrace.current),
      AsyncValue.data,
    );
  }
}
