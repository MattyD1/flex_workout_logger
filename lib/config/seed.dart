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

  late final initialExercises = initialExerciseNames.map(
    (e) => Exercise(
      ObjectId(),
      e,
      '',
      DateTimeX.current.toUtc(),
      DateTimeX.current.toUtc(),
    ),
  );

  realm.addAll(initialExercises);
}
