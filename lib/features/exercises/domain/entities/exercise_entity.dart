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
    required List<String> coachingCues,
    required Engagement engagement,
    required Style style,
    required DateTime createdAt,
    required DateTime updatedAt,

    // Optional Parameters
    String? description,
    ExerciseEntity? parentExercise,

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
    required Unit unit,
  }) = _Load;
}

/// [Unit] Enum
enum Unit {
  /// Pounds
  lbs,

  /// Kilograms
  kg;

  factory Unit.parse(String input) => tryParse(input)!;
  static final _nameMap = values.asNameMap();

  /// Returns the name of this enum constant, as contained in the declaration.
  static Unit? tryParse(String input) => _nameMap[input];
}

/// [Style] Enum
enum Style {
  /// Repititons
  reps,

  /// Timed
  timed;

  factory Style.parse(String input) => tryParse(input)!;
  static final _nameMap = values.asNameMap();

  /// Returns the name of this enum constant, as contained in the declaration.
  static Style? tryParse(String input) => _nameMap[input];
}

/// [Engagement] Enum
enum Engagement {
  /// Pounds
  bilateral,

  /// Kilograms
  unilateral,

  /// Bilateral with seperate weights;
  bilateralSeperate;

  factory Engagement.parse(String input) => tryParse(input)!;
  static final _nameMap = values.asNameMap();

  /// Returns the name of this enum constant, as contained in the declaration.
  static Engagement? tryParse(String input) => _nameMap[input];
}
