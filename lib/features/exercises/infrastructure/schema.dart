import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern_entity.dart';
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
      exercises: linkedExercises.map((e) => e.toEntity()).toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
