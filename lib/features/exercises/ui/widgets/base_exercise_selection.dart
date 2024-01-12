import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_base_exercise.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/exercise_card.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
class BaseExerciseSelection extends StatefulWidget {
  ///
  const BaseExerciseSelection({
    required this.exercises,
    required this.selectedValue,
    required this.onSelected,
    this.currentExerciseId,
    this.currentBaseExercise,
    super.key,
  });

  /// The values to display
  final List<ExerciseEntity> exercises;

  /// The currently selected value
  final ExerciseBaseExercise? selectedValue;

  /// The callback when a value is selected
  final ValueChanged<ExerciseEntity> onSelected;

  // Current exercise id - exercise can't be equal to itself as a base exercise
  final String? currentExerciseId;

  /// The current base exercise
  final ExerciseEntity? currentBaseExercise;

  @override
  State<BaseExerciseSelection> createState() => _BaseExerciseSelectionState();
}

class _BaseExerciseSelectionState extends State<BaseExerciseSelection> {
  ExerciseEntity? _selectedExercise;

  Future<Widget?> _showBottomSheet(BuildContext context) {
    return showModalBottomSheet<Widget>(
      context: context,
      showDragHandle: true,
      scrollControlDisabledMaxHeightRatio: 0.9,
      backgroundColor: context.colorScheme.offBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) => ListView.builder(
        itemCount: widget.exercises.length,
        itemBuilder: (context, index) {
          // TODO: Fix: a variant exercise can't be equal to any of its variations
          if (widget.currentExerciseId == widget.exercises[index].id) {
            return Container();
          }
          return Column(
            children: [
              ExerciseListTile(
                exercise: widget.exercises[index],
                trailingIcon: CupertinoIcons.add_circled,
                onTap: () {
                  widget.onSelected(widget.exercises[index]);

                  setState(() {
                    _selectedExercise = widget.exercises[index];
                  });

                  Navigator.of(context).pop();
                },
              ),
              Divider(
                color: context.colorScheme.divider,
                height: 1,
                indent: 64,
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(widget.currentBaseExercise != null) _selectedExercise = widget.currentBaseExercise;

    return Column(
      children: [
        Row(
          children: [
            Text('Base Exercise', style: context.textTheme.label),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        TextButton(
          onPressed: () {
            _showBottomSheet(context);
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero, // Set minimum size to zero
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: context.colorScheme.muted,
            ),
            child: Row(
              children: [
                Text(
                  _selectedExercise?.name ?? 'Select Base Exercise',
                  style: context.textTheme.bodyMedium.copyWith(
                    color: _selectedExercise == null
                        ? context.colorScheme.mutedForeground
                        : context.colorScheme.foreground,
                  ),
                ),
                const Spacer(),
                Icon(
                  CupertinoIcons.chevron_down,
                  color: context.colorScheme.mutedForeground,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppLayout.defaultPadding),
      ],
    );
  }
}
