import 'package:faker/faker.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern_entity.dart';
import 'package:flex_workout_logger/utils/date_time_extensions.dart';
import 'package:realm/realm.dart';

class MockMovementPattern {
  static List<MovementPatternEntity> generateEntityList(int amount) {
    final faker = Faker();
    final now = DateTimeX.current.toUtc();

    return List.generate(
      amount,
      (index) => MovementPatternEntity(
        id: ObjectId().hexString,
        name: faker.randomGenerator.string(50, min: 2),
        description: faker.randomGenerator.string(250),
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  static MovementPatternEntity generateEntity() {
    final faker = Faker();
    final now = DateTimeX.current.toUtc();

    return MovementPatternEntity(
      id: ObjectId().hexString,
      name: faker.randomGenerator.string(50, min: 2),
      description: faker.randomGenerator.string(250),
      createdAt: now,
      updatedAt: now,
    );
  }
}
