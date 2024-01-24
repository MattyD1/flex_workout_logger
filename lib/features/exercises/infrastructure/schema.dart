import 'package:flex_workout_logger/features/exercises/domain/entities/base_load_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/load_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group_entity.dart';
import 'package:realm/realm.dart';

part 'schema.g.dart';

@RealmModel()
class _Exercise {
  @PrimaryKey()
  late ObjectId id;

  late String name;
  late String description;

  @MapTo('engagement')
  late int engagementAsInt;
  Engagement get engagement => Engagement.values[engagementAsInt];
  set engagement(Engagement value) => engagementAsInt = value.index;

  @MapTo('style')
  late int styleAsInt;
  Style get style => Style.values[styleAsInt];
  set style(Style value) => styleAsInt = value.index;

  late _Exercise? baseExercise;
  late _MovementPattern? movementPattern;
  late List<_MuscleGroup> primaryMuscleGroups;
  late List<_MuscleGroup> secondaryMuscleGroups;

  late DateTime createdAt;
  late DateTime updatedAt;
}

/// _Exercise extension
extension ConvertExercise on _Exercise {
  /// Convert [_Exercise] to [ExerciseEntity]
  ExerciseEntity toEntity() {
    return ExerciseEntity(
      id: id.hexString,
      name: name,
      description: description,
      engagement: engagement,
      style: style,
      baseExercise: baseExercise?.toEntity(),
      movementPattern: movementPattern?.toEntity(),
      primaryMuscleGroups:
          primaryMuscleGroups.map((e) => e.toEntity()).toList(),
      secondaryMuscleGroups:
          secondaryMuscleGroups.map((e) => e.toEntity()).toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

@RealmModel()
class _MovementPattern {
  @PrimaryKey()
  late ObjectId id;

  late String name;
  late String description;

  late DateTime createdAt;
  late DateTime updatedAt;

  @Backlink(#movementPattern)
  late Iterable<_Exercise> linkedExercises;
}

/// _MovementPattern extension
extension ConvertMovementPattern on _MovementPattern {
  /// Convert [_MovementPattern] to [MovementPatternEntity]
  MovementPatternEntity toEntity() {
    return MovementPatternEntity(
      id: id.hexString,
      name: name,
      description: description,
      exerciseIds: linkedExercises.map((e) => e.id.hexString).toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

@RealmModel()
class _MuscleGroup {
  @PrimaryKey()
  late ObjectId id;

  late String name;
  late String description;

  late DateTime createdAt;
  late DateTime updatedAt;

  @Backlink(#primaryMuscleGroups)
  late Iterable<_Exercise> linkedPrimaryExercises;
  @Backlink(#primaryMuscleGroups)
  late Iterable<_Exercise> linkedSecondaryExercises;
}

/// _MuscleGroup extension
extension ConvertMuscleGroup on _MuscleGroup {
  /// Convert [_MuscleGroup] to [MuscleGroupEntity]
  MuscleGroupEntity toEntity() {
    return MuscleGroupEntity(
      id: id.hexString,
      name: name,
      description: description,
      primaryExerciseIds:
          linkedPrimaryExercises.map((e) => e.id.hexString).toList(),
      secondaryExerciseIds: linkedSecondaryExercises.map((e) => e.id.hexString).toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

@RealmModel()
class _BaseLoad {
  @PrimaryKey()
  late ObjectId id;

  late _Load? load;
  late bool assisted;
  late bool bodyWeight;

  late DateTime createdAt;
  late DateTime updatedAt;
}

/// _BaseLoad extension
extension ConvertBaseLoad on _BaseLoad {
  /// Convert [_BaseLoad] to [BaseLoadEntity]
  BaseLoadEntity toEntity() {
    return BaseLoadEntity(
      id: id.hexString,
      load: load!.toEntity(),
      assisted: assisted,
      bodyWeight: bodyWeight,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

@RealmModel()
class _Load {
  @PrimaryKey()
  late ObjectId id;

  late double weight;

  @MapTo('unit')
  late int unitAsInt;
  WeightUnit get unit => WeightUnit.values[unitAsInt];
  set unit(WeightUnit value) => unitAsInt = value.index;

  late DateTime createdAt;
  late DateTime updatedAt;
}

/// _Load extension
extension ConvertLoad on _Load {
  /// Convert [_Load] to [LoadEntity]
  LoadEntity toEntity() {
    return LoadEntity(
      id: id.hexString, 
      weight: weight, 
      unit: unit,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
