import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_entity.freezed.dart';

/// [ExerciseEntity] Model
@freezed
class ExerciseEntity with _$ExerciseEntity {
  /// [ExerciseEntity] factory constructor
  const factory ExerciseEntity({
    // Required Parameters (Needed for Quick Add Feature)
    required String id,
    required String name,
    required MovementPatternEntity movementPattern,
    required List<MuscleGroupEntity> muscleGroups,

    // Defaulted Parameters
    required int engagement,
    required int style,
    required DateTime createdAt,
    required DateTime updatedAt,

    // Optional Parameters
    String? description,
    List<String>? coachingCues,

    // Embedded Extensions
    BaseLoad? baseWeight,
    Load? oneRepMax,
    Load? tenRepMax,
  }) = _ExerciseEntity;
}

/// Embedded Extension [BaseLoad]
@freezed
class BaseLoad with _$BaseLoad {
  /// [BaseLoad] factory constructor
  const factory BaseLoad({
    required Load weight,
    required bool assisted,
    required bool autoFillBodyWeight,
  }) = _BaseLoad;
}

/// Embedded Extension [Load]
@freezed
class Load with _$Load {
  /// [Load] factory constructor
  const factory Load({
    required double weight,
    required int unit,
  }) = _Load;
}
