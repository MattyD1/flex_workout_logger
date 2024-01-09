import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_entity.freezed.dart';

/// Strongly Typed Model [ExerciseEntity]
@freezed
class ExerciseEntity with _$ExerciseEntity {
  /// [ExerciseEntity] factory constructor
  const factory ExerciseEntity({
    required String id,
    required String name,
    required String description,
    required Engagement engagement,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ExerciseEntity;
}

/// Engagement enum
enum Engagement {
  /// Bilateral
  bilateral,

  /// Bilateral separate
  bilateralSeparate,

  /// Unilateral
  unilateral;
}
