import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/controllers/movement_pattern_list_controller.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/movement_pattern_card.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flex_workout_logger/widgets/app_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Movement pattern list
class MovementPatternList extends ConsumerWidget {
  /// Constructor
  const MovementPatternList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movementPatterns = ref.watch(movementPatternListControllerProvider);

    return movementPatterns.when(
      data: (items) => items.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(AppLayout.miniPadding),
              child: Center(
                child: Text('No items found'),
              ),
            )
          : Column(
              children: [
                ...items.map((mp) => Column(
                  children: [
                    MovementPatternCard(
                      movementPattern: mp
                    ),
                    Divider(
                      color: context.colorScheme.divider,
                      height: 1,
                      indent: 64,
                    ),
                  ],
                )),
              ],
            ),
      error: (o, e) => AppError(
        title: o.toString(),
      ),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
