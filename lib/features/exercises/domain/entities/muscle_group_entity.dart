import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'muscle_group_entity.freezed.dart';

/// [MuscleGroupEntity] Model
@freezed
class MuscleGroupEntity with _$MuscleGroupEntity {
  /// [MuscleGroupEntity] factory constructor
  const factory MuscleGroupEntity({
    required String id,
    required String name,
    Iterable<ExerciseEntity>? linkedExercises,
  }) = _MuscleGroupEntity;
}
