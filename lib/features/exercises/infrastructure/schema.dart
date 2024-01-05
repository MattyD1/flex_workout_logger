import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:realm/realm.dart';

part 'schema.g.dart';

@RealmModel()
class _Exercise {
  // Required
  @PrimaryKey()
  late ObjectId id;

  late String name;

  late _MovementPattern? movementPattern;
  late List<_MuscleGroup> muscleGroups;

  // Deafults
  List<String> coachingCues = [];

  // Enums
  @MapTo('engagement')
  int engagementAsInt = 0;
  Engagement get engagement => Engagement.values[engagementAsInt];
  set engagement(Engagement engagement) => engagementAsInt = engagement.index;

  @MapTo('style')
  int styleAsInt = 0;
  Style get style => Style.values[styleAsInt];
  set style(Style style) => styleAsInt = style.index;

  late DateTime createdAt;
  late DateTime updatedAt;

  // Optional Parameters
  String? description;
  _Exercise? parentExercise;

  // Embedded Extensions
  _BaseLoad? baseWeight;
  _Load? oneRepMax;
  _Load? tenRepMax;
}

@RealmModel()
class _MovementPattern {
  @PrimaryKey()
  late ObjectId id;

  late String name;

  @Backlink(#movementPattern)
  late Iterable<_Exercise> linkedExercises;
}

@RealmModel()
class _MuscleGroup {
  @PrimaryKey()
  late ObjectId id;

  late String name;

  @Backlink(#muscleGroups)
  late Iterable<_Exercise> linkedExercises;
}

@RealmModel(ObjectType.embeddedObject)
class _BaseLoad {
  late _Load? weight;
  late bool assisted;
  late bool autoFillBodyWeight;
}

@RealmModel(ObjectType.embeddedObject)
class _Load {
  late double weight;

  // Unit Enum
  @MapTo('unit')
  late int unitAsInt;
  Unit get unit => Unit.values[unitAsInt];
  set unit(Unit unit) => unitAsInt = unit.index;
}
