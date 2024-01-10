import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_list_controller.dart';
import 'package:flex_workout_logger/features/exercises/ui/screens/exercises_create_screen.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/exercise_card.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flex_workout_logger/widgets/app_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

/// Exercises list on library screen
class ExercisesList extends ConsumerWidget {
  /// Constructor
  const ExercisesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercises = ref.watch(exercisesListControllerProvider);
    return exercises.when(
      data: (items) => items.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(AppLayout.miniPadding),
              child: Center(
                child: Text('No items found'),
              ),
            )
          : SlidableAutoCloseBehavior(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppLayout.defaultPadding,
                      vertical: AppLayout.smallPadding,
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: context.colorScheme.foreground,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppLayout.defaultPadding,
                            vertical: AppLayout.smallPadding,
                          ),
                          child: Text(
                            'Exercises',
                            style: TextStyle(
                              fontSize: 14,
                              color: context.colorScheme.background,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppLayout.miniPadding),
                        IconButton.filled(
                          iconSize: 20,
                          style: IconButton.styleFrom(
                            backgroundColor: context.colorScheme.muted,
                            foregroundColor: context.colorScheme.foreground,
                          ),
                          onPressed: () => {
                            context.goNamed(
                              ExercisesCreateScreen.routeName,
                            ),
                          },
                          icon: const Icon(CupertinoIcons.add),
                        ),
                      ],
                    ),
                  ),
                  ...items.map(
                    (e) => Column(
                      children: [
                        ExercisesCard(
                          exercise: e,
                        ),
                        Divider(
                          color: context.colorScheme.divider,
                          height: 1,
                          indent: 64,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      error: (o, e) => AppError(
        title: o.toString(),
      ),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
