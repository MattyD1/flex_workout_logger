import 'package:faker/faker.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_base_exercise.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_description.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_engagement.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_movement_pattern.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_name.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_style.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/repositories/exercise_repository.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/schema.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:realm/realm.dart';

import '../../../../mocks/test_exercises.dart';
import '../../../../mocks/test_movement_pattern.dart';
import '../../../../utils/initialize_database.dart';

void main() {
  late Realm realm;
  late Faker faker;

  setUp(() {
    faker = Faker();
    realm = Realm(
      Configuration.inMemory(
        [Exercise.schema, MovementPattern.schema],
      ),
    );
  });
  tearDown(() {
    realm.close();
  });

  ExerciseRepository makeRepository() => ExerciseRepository(realm: realm);

  group('ExerciseRepository', () {
    test('Create Exercise', () async {
      final initialData = MockMovementPattern.generateList(10);
      initializeDatabase(realm, initialData);

      final repository = makeRepository();

      final movementPatternToAdd = faker.randomGenerator.element(initialData);

      final res = await repository.createExercise(
        ExerciseName('Test exercise'),
        ExerciseDescription('New Description'),
        ExerciseEngagement(Engagement.bilateral),
        ExerciseStyle(Style.reps),
        ExerciseBaseExercise(null, null),
        ExerciseMovementPattern(movementPatternToAdd.toEntity()),
      );

      final exercise = res.fold((l) => null, (r) => r);

      expect(res.isRight(), true); // Assert that response is successfull
      expect(exercise, isNotNull); // Assert that exercise is not null
      expect(exercise!.name, 'Test exercise'); // Assert that name is correct
    });

    test('deleteExercise', () async {
      final initialData = MockExercises.generateList(10);
      initializeDatabase(realm, initialData);

      final repository = makeRepository();

      final itemToDelete = faker.randomGenerator.element(initialData);

      final res = await repository.deleteExercise(itemToDelete.id.hexString);

      final deleted = res.fold((l) => throw l, (r) => r);

      expect(res.isRight(), true); // Assert that response is successfull
      expect(deleted, true); // Assert that exercise is not null
    });

    test('deleteManyExercises', () async {
      final initialData = MockExercises.generateList(10);
      initializeDatabase(realm, initialData);

      final repository = makeRepository();

      final numberOfItemsToDelete = faker.randomGenerator.integer(9, min: 3);

      late final itemsToDelete = <String>[];

      for (var i = 0; i < numberOfItemsToDelete; i++) {
        itemsToDelete.add(initialData[i].id.hexString);
      }

      final res = await repository.deleteMultipleExercises(itemsToDelete);

      final deleted = res.fold((l) => throw l, (r) => r);

      expect(res.isRight(), true); // Assert that response is successfull
      expect(
        deleted,
        numberOfItemsToDelete,
      ); // Assert that exercise is not null
    });

    test('getExerciseById', () async {
      final initialData = MockExercises.generateList(10);
      initializeDatabase(realm, initialData);

      final repository = makeRepository();

      final itemToGet = faker.randomGenerator.element(initialData);

      final res = await repository.getExerciseById(itemToGet.id.hexString);

      final exercise = res.fold((l) => throw l, (r) => r);

      expect(res.isRight(), true); // Assert that response is successfull
      expect(exercise, isNotNull); // Assert that exercise is not null
      expect(exercise.id, itemToGet.id.hexString); // Assert that id is correct
    });

    test('getExercises', () async {
      final initialData = MockExercises.generateList(10);
      initializeDatabase(realm, initialData);

      final repository = makeRepository();

      final res = await repository.getExercises();

      final exercise = res.fold((l) => throw l, (r) => r);

      expect(res.isRight(), true); // Assert that response is successfull
      expect(exercise, isNotNull); // Assert that exercise is not null
      expect(
        exercise.length,
        initialData.length,
      ); // Assert that id is correct
    });

    test('updateExercise', () async {
      final initialData = MockExercises.generateList(10);
      initializeDatabase(realm, initialData);

      final repository = makeRepository();

      final itemToUpdate = faker.randomGenerator.element(initialData);

      final res = await repository.updateExercise(
        itemToUpdate.id.hexString,
        ExerciseName('Updated exercise'),
        ExerciseDescription('New Description'),
        ExerciseEngagement(Engagement.bilateral),
        ExerciseStyle(Style.reps),
        ExerciseBaseExercise(null, itemToUpdate.baseExercise?.toEntity()),
        ExerciseMovementPattern(null),
      );

      final exercise = res.fold((l) => throw l, (r) => r);

      expect(res.isRight(), true); // Assert that response is successfull
      expect(exercise, isNotNull); // Assert that exercise is not null
      expect(
        exercise.name,
        'Updated exercise',
      ); // Assert that id is correct
      expect(
        exercise.id,
        itemToUpdate.id.hexString,
      ); // Assert that id is correct
    });
  });
}
