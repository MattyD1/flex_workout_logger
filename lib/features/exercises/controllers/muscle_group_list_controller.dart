import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group_entity.dart';
import 'package:flex_workout_logger/features/exercises/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'muscle_group_list_controller.g.dart';

/// Controller for the muscle group list
@riverpod
class MuscleGroupListController extends _$MuscleGroupListController {
  @override
  FutureOr<List<MuscleGroupEntity>> build() async {
    final res =
        await ref.watch(muscleGroupRepositoryProvider).getMuscleGroups();
    return res.fold((l) => throw l, (r) => r);
  }

  /// Add an entity to list
  void addMuscleGroup(MuscleGroupEntity entity) {
    final items = state.valueOrNull ?? [];

    state = const AsyncValue.loading();

    items.add(entity);
    state = AsyncValue.data(items);
  }

  /// Update an entity in the list
  void editMuscleGroup(MuscleGroupEntity entity) {
    final items = state.valueOrNull ?? [];

    state = const AsyncValue.loading();

    final i = items.indexWhere((element) => element.id == entity.id);
    if (i != -1) {
      items
        ..removeAt(i)
        ..insert(i, entity);
    }

    state = AsyncValue.data(items);
  }

  /// Delete an entity in the list
  void deleteMuscleGroup(MuscleGroupEntity entity) {
    final items = state.valueOrNull ?? [];

    state = const AsyncValue.loading();

    items.remove(entity);
    state = AsyncValue.data(items);
  }
}
