import 'package:faker/faker.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/repositories/muscle_group_repository.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/schema.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:realm/realm.dart';

import '../../../../mocks/test_muscle_group.dart';
import '../../../../utils/initialize_database.dart';

void main() {
  late Realm realm;
  late Faker faker;

  setUp(() {
    faker = Faker();
    realm = Realm(
      Configuration.inMemory(
        [Exercise.schema, MovementPattern.schema, MuscleGroup.schema],
      ),
    );
  });
  tearDown(() {
    realm.close();
  });

  MuscleGroupRepository makeRepository() => MuscleGroupRepository(realm: realm);

  group('MuscleGroupRepository', () {
    test('getExercises', () async {
      final initialData = MockMuscleGroup.generateList(10);
      initializeDatabase(realm, initialData);

      final repository = makeRepository();

      final res = await repository.getMuscleGroups();

      final muscleGroups = res.fold((l) => throw l, (r) => r);

      expect(res.isRight(), true); // Assert that response is successfull
      expect(muscleGroups, isNotNull); // Assert that exercise is not null
      expect(
        muscleGroups.length,
        initialData.length,
      ); // Assert that all items are returned
    });
  });
}
