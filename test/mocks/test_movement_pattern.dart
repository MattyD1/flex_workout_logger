import 'package:faker/faker.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/schema.dart';
import 'package:flex_workout_logger/utils/date_time_extensions.dart';
import 'package:realm/realm.dart';

class MockMovementPattern {
  static List<MovementPattern> generateList(int amount) {
    final faker = Faker();
    final now = DateTimeX.current.toUtc();

    return List.generate(
      amount,
      (index) => MovementPattern(
        ObjectId(),
        faker.randomGenerator.string(50, min: 2),
        faker.randomGenerator.string(250),
        now,
        now,
      ),
    );
  }

  static MovementPattern generate() {
    final faker = Faker();
    final now = DateTimeX.current.toUtc();

    return MovementPattern(
      ObjectId(),
      faker.randomGenerator.string(50, min: 2),
      faker.randomGenerator.string(250),
      now,
      now,
    );
  }
}
