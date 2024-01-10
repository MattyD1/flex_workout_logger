import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
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
  late int stlyeAsInt;
  Style get style => Style.values[stlyeAsInt];
  set style(Style value) => stlyeAsInt = value.index;


  late DateTime createdAt;
  late DateTime updatedAt;
}

/// _Exercise extension
extension Convert on _Exercise {
  /// Convert [_Exercise] to [ExerciseEntity]
  ExerciseEntity toEntity() {
    return ExerciseEntity(
      id: id.hexString,
      name: name,
      description: description,
      engagement: engagement,
      style: style,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
