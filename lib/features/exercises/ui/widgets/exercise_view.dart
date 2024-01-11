import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_delete_controller.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_list_controller.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/ui/screens/exercises_edit_screen.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flex_workout_logger/widgets/icon_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// The detail view of an exercise
class ExerciseView extends ConsumerWidget {
  ///
  const ExerciseView({required this.exercise, super.key});

  /// The exercise the card represents
  final ExerciseEntity exercise;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        /// Row holds summary
        Row(
          children: [
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '230',
                      style: context.textTheme.titleLarge.copyWith(
                        height: 1,
                      ),
                    ),
                    const SizedBox(
                      width: AppLayout.miniPadding,
                    ),
                    Text(
                      'lbs',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'One Rep Max',
                  style: context.textTheme.bodySmall.copyWith(
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                Text(
                  '1287',
                  style: context.textTheme.titleSmall,
                ),
                Text(
                  'Total Reps',
                  style: context.textTheme.bodySmall.copyWith(
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              children: [
                Text(
                  '124',
                  style: context.textTheme.titleSmall,
                ),
                Text(
                  'Total Sets',
                  style: context.textTheme.bodySmall.copyWith(
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        /// Hold buttons
        Row(
          children: [
            IconTextButton(
              icon: CupertinoIcons.pencil,
              text: 'Edit',
              onPressed: () => context.goNamed(
                ExercisesEditScreen.routeName,
                pathParameters: {
                  'eid': exercise.id,
                },
              ),
            ),
            const SizedBox(width: 16),
            IconTextButton(
              icon: CupertinoIcons.share,
              text: 'Share',
              onPressed: () {},
            ),
            const SizedBox(width: 16),
            IconTextButton(
              icon: CupertinoIcons.square_on_square,
              text: 'Copy',
              onPressed: () {},
            ),
            const SizedBox(width: 16),
            IconTextButton(
              icon: CupertinoIcons.trash,
              text: 'Delete',
              onPressed: () => {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Are you sure about that?'),
                      content: const Text('This will delete the exercise'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            ref
                                .read(
                                  exercisesDeleteControllerProvider(exercise.id)
                                      .notifier,
                                )
                                .handle();

                            ref
                                .read(exercisesListControllerProvider.notifier)
                                .deleteExercise(exercise);

                            Navigator.of(context).pop(); // Pop the dialog
                            context.pop(); // Pop the screen
                          },
                          child: const Text('Confirm'),
                        ),
                      ],
                    );
                  },
                ),
              },
            ),
          ],
        ),

        const SizedBox(height: 14),
        Divider(
          color: context.colorScheme.divider,
        ),
        const SizedBox(height: 16),

        /// General information
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'General',
              style: context.textTheme.headlineLarge,
            ),
            if (exercise.description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  exercise.description,
                  style: context.textTheme.bodyMedium.copyWith(
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                _bubble(context, 'Horizontal Push'),
                const SizedBox(width: 8),
                _bubble(context, 'Bilateral'),
                const SizedBox(width: 8),
                _bubble(context, 'Reps'),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Muscle Groups',
              style: context.textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _bubble(context, 'Chest', isPrimary: true),
                const SizedBox(width: 8),
                _bubble(context, 'Deltoids'),
                const SizedBox(width: 8),
                _bubble(context, 'Triceps'),
              ],
            ),
          ],
        ),
        // TODO: Progress graph
      ],
    );
  }

  Widget _bubble(BuildContext context, String text, {bool isPrimary = false}) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(
        color: isPrimary
            ? context.colorScheme.foreground
            : context.colorScheme.muted,
        padding: const EdgeInsets.symmetric(
          horizontal: AppLayout.defaultPadding,
          vertical: AppLayout.miniPadding,
        ),
        child: Text(
          text,
          style: context.textTheme.bodyMedium.copyWith(
            color: isPrimary
                ? context.colorScheme.background
                : context.colorScheme.foreground,
          ),
        ),
      ),
    );
  }
}
