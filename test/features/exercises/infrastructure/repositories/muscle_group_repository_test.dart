import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/muscle_group_description.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/muscle_group_name.dart';
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
    test('Create Muscle Group', () async {
      final repository = makeRepository();

      final res = await repository.createMuscleGroup(
        MuscleGroupName('Test muscle group'), 
        MuscleGroupDescription('New Description'),
      );

      final muscleGroup = res.fold((l) => null, (r) => r);

      expect(res.isRight(), true); // Assert that response is successfull
      expect(muscleGroup, isNotNull); // Assert that muscle group is not null
      expect(muscleGroup!.name, 'Test muscle group'); // Assert that name is correct
    });

    test('getMuscleGroups', () async {
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
