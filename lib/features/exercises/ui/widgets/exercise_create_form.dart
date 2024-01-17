import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_create_controller.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_list_controller.dart';
import 'package:flex_workout_logger/features/exercises/controllers/movement_pattern_list_controller.dart';
import 'package:flex_workout_logger/features/exercises/controllers/muscle_group_list_controller.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_base_exercise.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_description.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_engagement.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_movement_pattern.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_name.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_style.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/exercise_card.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/movement_pattern_create_form.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/muscle_group_selection_sheet.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/variation_segment_controller.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flex_workout_logger/widgets/ui/radio_list.dart';
import 'package:flex_workout_logger/widgets/ui/selection_sheet.dart';
import 'package:flex_workout_logger/widgets/ui/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Form that allows users to enter the name of the exercise and create it
class ExerciseCreateForm extends ConsumerStatefulWidget {
  ///
  const ExerciseCreateForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExerciseCreateFormState();
}

class _ExerciseCreateFormState extends ConsumerState<ExerciseCreateForm> {
  final _formKey = GlobalKey<FormState>();

  ExerciseName? _name;
  ExerciseDescription? _description;
  Engagement? _engagement = Engagement.bilateral;
  Style? _style = Style.reps;

  ExerciseBaseExercise? _baseExercise;

  ExerciseMovementPattern? _movementPattern;

  int _selectedVariation = 1;

  void _onVariationChanged(int index) {
    setState(() {
      if (index == 1) {
        _baseExercise = ExerciseBaseExercise(null, null);
      }
      _selectedVariation = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<ExerciseEntity?>>(exercisesCreateControllerProvider,
        (previous, next) {
      next.maybeWhen(
        data: (data) {
          if (data == null) return;

          ref.read(exercisesListControllerProvider.notifier).addExercise(data);
          context.pop();
        },
        orElse: () {},
      );
    });

    final variationExercises = ref
        .read(exercisesListControllerProvider.notifier)
        .getBaseExerciseList();

    final movementPatterns = ref.watch(movementPatternListControllerProvider);

    final muscleGroups = ref.watch(muscleGroupListControllerProvider);

    final res = ref.watch(exercisesCreateControllerProvider);
    final errorText = res.maybeWhen(
      error: (error, stackTrace) => error.toString(),
      orElse: () => null,
    );

    final isLoading = res.maybeWhen(
      data: (_) => res.isRefreshing,
      loading: () => true,
      orElse: () => false,
    );

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          Text(
            'Is this a new exercise or a variation on an existing one?',
            style: context.textTheme.headlineLarge,
          ),
          const SizedBox(height: AppLayout.smallPadding),
          VariationSegementedController(
            selectedValue: _selectedVariation,
            onValueChanged: _onVariationChanged,
          ),
          const SizedBox(height: AppLayout.defaultPadding),
          MuscleGroupSelectionSheet<MuscleGroupEntity>(
            items: muscleGroups.asData?.value
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: CupertinoListTile(
                          title: Text(
                            e.name,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.listTitle.copyWith(
                              color: context.colorScheme.foreground,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop(e);
                          },
                          leading: const Icon(Icons.fitness_center),
                          padding: const EdgeInsets.fromLTRB(
                            20,
                            16,
                            14,
                            16,
                          ),
                        ),
                      ),
                    )
                    .toList() ??
                [],
          ),
          const SizedBox(height: AppLayout.defaultPadding),
          if (_selectedVariation == 2)
            SelectionSheet<ExerciseEntity>(
              validator: (value) => _baseExercise?.validate,
              hintText: 'Select a base exercise',
              labelText: 'Base Exercise',
              onChanged: (value) =>
                  _baseExercise = ExerciseBaseExercise(null, value),
              items: variationExercises.asData?.value
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: ExerciseListTile(
                            exercise: e,
                            trailingIcon: CupertinoIcons.add_circled,
                            onTap: () {
                              Navigator.of(context).pop(e);
                            },
                          ),
                        ),
                      )
                      .toList() ??
                  [],
            ),
          MyTextField(
            label: _selectedVariation == 1 ? 'Exercise Name' : 'Variation Name',
            hintText: _selectedVariation == 1
                ? 'Bench Press, Squat, etc.'
                : 'Paused, 3” Bands, Alternating, etc...',
            errorText: errorText,
            onChanged: (value) => _name = ExerciseName(value),
            validator: (value) => _name?.validate,
            controller: null,
            readOnly: isLoading,
            isRequired: true,
          ),
          const SizedBox(height: AppLayout.defaultPadding),
          MyTextField(
            label: 'Description',
            hintText: _selectedVariation == 1
                ? 'Describe the exercise, including any additional setup that is required.'
                : 'Describe of the variation including the main differences between itself and its base exercise.',
            errorText: errorText,
            onChanged: (value) => _description = ExerciseDescription(value),
            validator: (value) => _description?.validate,
            controller: null,
            readOnly: isLoading,
            isTextArea: true,
          ),
          const SizedBox(height: AppLayout.defaultPadding),
          SelectionSheet<MovementPatternEntity>(
            validator: (value) => _movementPattern?.validate,
            hintText: 'Select a movement pattern',
            labelText: 'Movement Pattern',
            isRequired: true,
            onChanged: (value) =>
                _movementPattern = ExerciseMovementPattern(value),
            items: movementPatterns.asData?.value
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: CupertinoListTile(
                          title: Text(
                            e.name,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.listTitle.copyWith(
                              color: context.colorScheme.foreground,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop(e);
                          },
                          leading: const Icon(Icons.fitness_center),
                          padding: const EdgeInsets.fromLTRB(
                            20,
                            16,
                            14,
                            16,
                          ),
                        ),
                      ),
                    )
                    .toList() ??
                [],
            canCreate: true,
            createForm: const MovementPatternCreateForm(),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Engagement',
                  style: context.textTheme.label,
                ),
                const Text(
                  'How the body engages with the lift during the movement.',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppLayout.smallPadding),
          RadioList<Engagement>(
            selectedValue: Engagement.bilateral,
            onSelected: (Engagement? value) {
              setState(() {
                _engagement = value;
              });
            },
            values: Engagement.values.toList(),
            groupValue: _engagement,
          ),
          const SizedBox(height: AppLayout.defaultPadding),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Style',
                  style: context.textTheme.label,
                ),
                const Text(
                  'What is the style of the exercise.',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppLayout.smallPadding),
          RadioList<Style>(
            selectedValue: Style.reps,
            onSelected: (Style? value) {
              setState(() {
                _style = value;
              });
            },
            values: Style.values.toList(),
            groupValue: _style,
          ),
          const SizedBox(height: AppLayout.defaultPadding),
          ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    if (_name == null) return;
                    ref.read(exercisesCreateControllerProvider.notifier).handle(
                          _name!,
                          _description,
                          ExerciseEngagement(
                            _engagement ?? Engagement.bilateral,
                          ),
                          ExerciseStyle(
                            _style ?? Style.reps,
                          ),
                          _baseExercise,
                          _movementPattern!,
                        );

                    // FIX: engagement should not be hardcoded
                  },
            child: isLoading
                ? const CircularProgressIndicator()
                : const Text('Create'),
          ),
        ],
      ),
    );
  }
}
