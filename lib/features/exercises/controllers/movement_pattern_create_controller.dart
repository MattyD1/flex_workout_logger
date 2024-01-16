import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/movement_pattern_description.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/movement_pattern_name.dart';
import 'package:flex_workout_logger/features/exercises/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movement_pattern_create_controller.g.dart';

///
@riverpod
class MovementPatternCreateController extends _$MovementPatternCreateController {
  @override
  FutureOr<MovementPatternEntity?> build() {
    return null;
  }

  ///
  Future<void> handle(
    MovementPatternName name,
    MovementPatternDescription? description,
  ) async {
    state = const AsyncLoading();
    final res = await ref.read(movementPatternRepositoryProvider).createMovementPattern(
          name,
          description,
        );
    state = res.fold(
      (l) => AsyncValue.error(l.error, StackTrace.current),
      AsyncValue.data,
    );
  }
}