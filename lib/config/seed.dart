import 'package:flex_workout_logger/features/exercises/infrastructure/schema.dart';
import 'package:flex_workout_logger/utils/date_time_extensions.dart';
import 'package:realm/realm.dart';

/// Seeds the realm with data on first load
void realmSeed(Realm realm) {
  final initialExerciseNames = <String>[
    'Bench Press',
    'Squat',
    'Deadlift',
    'Overhead Press',
    'Barbell Row',
    'Pull Up',
    'Chin Up',
    'Dip',
    'Push Up',
    'Sit Up',
    'Crunch',
    'Plank',
    'Lunge',
    'Calf Raise',
    'Leg Press',
    'Leg Curl',
    'Leg Extension',
    'Leg Raise',
  ];

  final initialMovementPatternNames = <String>[
    'Squat',
    'Hip Hinge',
    'Vertical Pull',
    'Vertical Push',
    'Horizontal Pull',
    'Horizontal Push',
    'Hip Extension',
    'Pull Over',
    'Fly',
    'Isolation',
    'Carrying',
    'Jumping',
    'Mobility',
  ];

  final initialMuscleGroupNames = <String>[
    'Quads',
    'Glutes',
    'Hamstrings',
    'Erectors',
    'Lats',
    'Biceps',
    'Shoulders',
    'Triceps',
    'Retractors',
    'Chest',
    'Calves',
    'Abs',
    'Forearms',
    'Neck',
    'Groin',
  ];

  late final initialExercises = initialExerciseNames.map(
    (e) => Exercise(
      ObjectId(),
      e,
      '',
      1,
      0,
      DateTimeX.current.toUtc(),
      DateTimeX.current.toUtc(),
    ),
  );

  late final initialMovementPatterns = initialMovementPatternNames.map(
    (e) => MovementPattern(
      ObjectId(),
      e,
      '',
      DateTimeX.current.toUtc(),
      DateTimeX.current.toUtc(),
    ),
  );

  late final initialMuscleGroups = initialMuscleGroupNames.map(
    (e) => MuscleGroup(
      ObjectId(),
      e,
      '',
      DateTimeX.current.toUtc(),
      DateTimeX.current.toUtc(),
    ),
  );

  realm
    ..addAll(initialExercises)
    ..addAll(initialMovementPatterns)
    ..addAll(initialMuscleGroups);
}
