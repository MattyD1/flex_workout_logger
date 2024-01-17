import 'package:freezed_annotation/freezed_annotation.dart';

part 'muscle_group_entity.freezed.dart';

/// Strongly Typed Model [MuscleGroupEntity]
@freezed
class MuscleGroupEntity with _$MuscleGroupEntity {
  /// [MuscleGroupEntity] factory constructor
  const factory MuscleGroupEntity({
    required String id,
    required String name,
    required String description,
    required DateTime createdAt,
    required DateTime updatedAt,
    List<String>? primaryExerciseIds,
  }) = _MuscleGroupEntity;
}
