import 'package:faker/faker.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/schema.dart';
import 'package:flex_workout_logger/utils/date_time_extensions.dart';
import 'package:realm/realm.dart';

class MockExercises {
  static List<Exercise> generateList(int amount) {
    final faker = Faker();
    final now = DateTimeX.current.toUtc();

    return List.generate(
      amount,
      (index) => Exercise(
        ObjectId(),
        faker.randomGenerator.string(100, min: 2),
        faker.randomGenerator.string(500),
        faker.randomGenerator.integer(2),
        faker.randomGenerator.integer(1),
        now,
        now,
      ),
    );
  }

  static Exercise generate() {
    final faker = Faker();
    final now = DateTimeX.current.toUtc();

    return Exercise(
      ObjectId(),
      faker.randomGenerator.string(100, min: 2),
      faker.randomGenerator.string(500),
      faker.randomGenerator.integer(2),
      faker.randomGenerator.integer(1),
      now,
      now,
    );
  }
}
