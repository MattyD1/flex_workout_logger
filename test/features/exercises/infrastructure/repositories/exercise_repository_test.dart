import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_name.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/repositories/exercise_repository.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/schema.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:realm/realm.dart';

void main() {
  late Realm realm;
  setUp(() {
    realm = Realm(Configuration.inMemory([Exercise.schema]));
  });
  tearDown(() {
    realm.close();
  });

  ExerciseRepository makeRepository() => ExerciseRepository(realm: realm);

  group('ExerciseRepository', () {
    test('Create Exercise', () async {
      final repository = makeRepository();

      final res =
          await repository.createExercise(ExerciseName('Test exercise'));

      final exercise = res.fold((l) => null, (r) => r);

      expect(res.isRight(), true); // Assert that response is successfull
      expect(exercise, isNotNull); // Assert that exercise is not null
      expect(exercise!.name, 'Test exercise'); // Assert that name is correct
    });
  });
}
