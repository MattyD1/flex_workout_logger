import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern_entity.dart';
import 'package:flex_workout_logger/utils/enum_abstract.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_entity.freezed.dart';

/// Strongly Typed Model [ExerciseEntity]
@freezed
class ExerciseEntity with _$ExerciseEntity {
  /// [ExerciseEntity] factory constructor
  const factory ExerciseEntity({
    required String id,
    required String name,
    required String description,
    required Engagement engagement,
    required Style style,
    required DateTime createdAt,
    required DateTime updatedAt,
    ExerciseEntity? baseExercise,
    MovementPatternEntity? movementPattern,
  }) = _ExerciseEntity;
}

/// Engagement enum
enum Engagement implements Enumeration<Engagement> {
  ///
  bilateral(
    name: 'Bilateral',
    description:
        'Exercises where both sides of the body work together in unison, typically with a single resistance source. Ex: Squat',
  ),

  ///
  bilateralSeparate(
    name: 'Bilateral With Separate Weights',
    description:
        'Exercise where both sides of the body also work together, but each side uses a separate weight. Ex: Dumbbell Bench Press',
  ),

  ///
  unilateral(
    name: 'Unilateral',
    description:
        'Exercises focus on working one side of the body at a time, allowing each limb or side to work independently. Ex: Bulgarian Split Squat and Lunges',
  );

  const Engagement({required this.name, this.description});

  @override
  final String name;

  @override
  final String? description;

  @override
  set name(String name) => name;

  @override
  set description(String? description) => description;
}

/// Style enum
enum Style implements Enumeration<Style> {
  /// Reps
  reps(name: 'Reps'),

  /// Timed
  timed(name: 'Timed');

  // ignore: unused_element
  const Style({required this.name, this.description});

  @override
  final String name;

  @override
  final String? description;

  @override
  set name(String name) => name;

  @override
  set description(String? description) => description;
}
