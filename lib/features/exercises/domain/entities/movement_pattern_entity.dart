import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movement_pattern_entity.freezed.dart';

/// [MovementPatternEntity] Model
@freezed
class MovementPatternEntity with _$MovementPatternEntity {
  /// [MovementPatternEntity] factory constructor
  const factory MovementPatternEntity({
    required String id,
    required String name,
    Iterable<ExerciseEntity>? linkedExercises,
  }) = _MovementPatternEntity;
}
