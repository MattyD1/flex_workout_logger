import 'package:flex_workout_logger/utils/enum_abstract.dart';
import 'package:flex_workout_logger/utils/interfaces.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'load_entity.freezed.dart';

/// Strongly Typed Model [LoadEntity]
@freezed
class LoadEntity with _$LoadEntity, DatabaseEntity {
  /// [LoadEntity] factory constructor
  const factory LoadEntity({
    required String id,
    required double weight,
    required WeightUnit unit,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _LoadEntity;
}

/// Unit enum
enum WeightUnit implements Enumeration<WeightUnit> {
  ///
  lbs(
    name: 'lbs',
    description: 'Pounds',
  ),

  ///
  kgs(
    name: 'kgs',
    description: 'Kilograms',
  );

  const WeightUnit({required this.name, this.description});

  @override
  final String name;

  @override
  final String? description;

  @override
  set name(String name) => name;

  @override
  set description(String? description) => description;
}