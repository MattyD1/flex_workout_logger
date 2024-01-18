import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/muscle_group_description.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/muscle_group_name.dart';
import 'package:flex_workout_logger/features/exercises/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'muscle_group_create_controller.g.dart';

///
@riverpod
class MuscleGroupCreateController
    extends _$MuscleGroupCreateController {
  @override
  FutureOr<MuscleGroupEntity?> build() {
    return null;
  }

  ///
  Future<MuscleGroupEntity?> handle(
    MuscleGroupName name,
    MuscleGroupDescription? description,
  ) async {
    state = const AsyncLoading();
    final res =
        await ref.read(muscleGroupRepositoryProvider).createMuscleGroup(
              name,
              description,
            );
    state = res.fold(
      (l) => AsyncValue.error(l.error, StackTrace.current),
      AsyncValue.data,
    );

    return res.fold((l) => null, (r) => r);
  }
}
