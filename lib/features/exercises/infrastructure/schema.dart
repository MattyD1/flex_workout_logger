import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:realm/realm.dart';

part 'schema.g.dart';

@RealmModel()
class _Exercise {
  @PrimaryKey()
  late ObjectId id;

  late String name;
  late String description;

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
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
