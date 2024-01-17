import 'package:faker/faker.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/schema.dart';
import 'package:flex_workout_logger/utils/date_time_extensions.dart';
import 'package:realm/realm.dart';

class MockMuscleGroup {
  static List<MuscleGroup> generateList(int amount) {
    final faker = Faker();
    final now = DateTimeX.current.toUtc();

    return List.generate(
      amount,
      (index) => MuscleGroup(
        ObjectId(),
        faker.randomGenerator.string(50, min: 2),
        faker.randomGenerator.string(250),
        now,
        now,
      ),
    );
  }

  static MuscleGroup generate() {
    final faker = Faker();
    final now = DateTimeX.current.toUtc();

    return MuscleGroup(
      ObjectId(),
      faker.randomGenerator.string(50, min: 2),
      faker.randomGenerator.string(250),
      now,
      now,
    );
  }
}
