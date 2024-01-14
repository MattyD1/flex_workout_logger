

import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern_entity.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A selectable card with [Movement Pattern]
class MovementPatternCard extends ConsumerWidget {

  ///
  const MovementPatternCard({required this.movementPattern, super.key});

  /// The movement pattern the card represents
  final MovementPatternEntity movementPattern;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoListTile (
      title: Text(
        movementPattern.name,
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.listTitle.copyWith(
          color: context.colorScheme.foreground
        ),
      ),
      subtitle: Text(
        movementPattern.description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.listSubtitle.copyWith(
          color: context.colorScheme.offForeground,
        ),
      ),
      leading: const Icon(Icons.fitness_center),
      padding: const EdgeInsets.fromLTRB(
        20,
        16,
        14,
        16,
      ),
    );
  }
}