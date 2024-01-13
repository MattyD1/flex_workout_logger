import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern_entity.dart';
import 'package:flex_workout_logger/features/exercises/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movement_pattern_list_controller.g.dart';

/// Controller for the movement pattern list
@riverpod
class MovementPatternListController extends _$MovementPatternListController {
  @override
  FutureOr<List<MovementPatternEntity>> build() async {
    final res = await ref
        .watch(movementPatternRepositoryProvider)
        .getMovementPatterns();
    return res.fold((l) => throw l, (r) => r);
  }

  /// Add an entity to list
  void addMovementPattern(MovementPatternEntity entity) {
    final items = state.valueOrNull ?? [];

    state = const AsyncValue.loading();

    items.add(entity);
    state = AsyncValue.data(items);
  }

  /// Update an entity in the list
  void editMovementPattern(MovementPatternEntity entity) {
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
  void deleteMovementPattern(MovementPatternEntity entity) {
    final items = state.valueOrNull ?? [];

    state = const AsyncValue.loading();

    items.remove(entity);
    state = AsyncValue.data(items);
  }
}
