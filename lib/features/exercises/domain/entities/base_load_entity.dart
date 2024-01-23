import 'package:flex_workout_logger/features/exercises/domain/entities/load_entity.dart';
import 'package:flex_workout_logger/utils/interfaces.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_load_entity.freezed.dart';

/// Strongly Typed Model [BaseLoadEntity]
@freezed
class BaseLoadEntity with _$BaseLoadEntity, DatabaseEntity {
  /// [BaseLoadEntity] factory constructor
  const factory BaseLoadEntity({
    required String id,
    required LoadEntity load,
    required bool assisted,
  }) = _BaseLoadEntity;
}
