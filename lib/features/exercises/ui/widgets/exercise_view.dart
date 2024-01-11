import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/main.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flex_workout_logger/widgets/icon_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// The detail view of an exercise
class ExerciseView extends StatelessWidget {
  ///
  const ExerciseView({required this.exercise, super.key});

  /// The exercise the card represents
  final ExerciseEntity exercise;

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
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
              onPressed: () {},
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
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Container(
                    color: context.colorScheme.muted,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppLayout.defaultPadding,
                      vertical: AppLayout.miniPadding,
                    ),
                    child: Text(
                      'Horizontal Push',
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Container(
                    color: context.colorScheme.muted,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppLayout.defaultPadding,
                      vertical: AppLayout.miniPadding,
                    ),
                    child: Text(
                      'Bilateral',
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Container(
                    color: context.colorScheme.muted,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppLayout.defaultPadding,
                      vertical: AppLayout.miniPadding,
                    ),
                    child: Text(
                      'Reps',
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                ),
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
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Container(
                    color: context.colorScheme.foreground,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppLayout.defaultPadding,
                      vertical: AppLayout.miniPadding,
                    ),
                    child: Text(
                      'Chest',
                      style: context.textTheme.bodyMedium.copyWith(
                        color: context.colorScheme.background,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Container(
                    color: context.colorScheme.muted,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppLayout.defaultPadding,
                      vertical: AppLayout.miniPadding,
                    ),
                    child: Text(
                      'Deltoids',
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Container(
                    color: context.colorScheme.muted,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppLayout.defaultPadding,
                      vertical: AppLayout.miniPadding,
                    ),
                    child: Text(
                      'Triceps',
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        // TODO: Progress graph
        // Text(exercise.name),
        // Text(exercise.description),
        // Text(exercise.engagement.toString()),
        // Text(exercise.style.toString()),
        // Text(exercise.createdAt.toIso8601String()),
        // Text(exercise.updatedAt.toIso8601String()),
      ],
    );
  }
}
