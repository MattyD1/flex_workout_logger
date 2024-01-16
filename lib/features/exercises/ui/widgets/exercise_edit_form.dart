import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_edit_controller.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_list_controller.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_base_exercise.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_description.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_engagement.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_movement_pattern.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_name.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_style.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flex_workout_logger/widgets/ui/radio_list.dart';
import 'package:flex_workout_logger/widgets/ui/selection_sheet.dart';
import 'package:flex_workout_logger/widgets/ui/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

///
class ExerciseEditForm extends ConsumerStatefulWidget {
  ///
  const ExerciseEditForm({required this.id, super.key});

  /// Exercise id
  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExerciseEditFormState();
}

class _ExerciseEditFormState extends ConsumerState<ExerciseEditForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  ExerciseEntity? _currentBaseExercise;

  ExerciseName? _name;
  ExerciseDescription? _description;
  Engagement? _engagement;
  Style? _style;
  ExerciseBaseExercise? _baseExercise;
  ExerciseMovementPattern? _movementPattern;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    ref.listenManual(exercisesEditControllerProvider(widget.id), (
      AsyncValue<ExerciseEntity>? prev,
      AsyncValue<ExerciseEntity> next,
    ) {
      // Initialize name
      final v = next.asData?.value.name ?? 'No name found';
      _nameController.text = v;
      _name = ExerciseName(v);

      // Initialize description
      final d = next.asData?.value.description ?? 'No description found';
      _descriptionController.text = d;
      _description = ExerciseDescription(d);

      // Initalize engagement
      _engagement = next.asData?.value.engagement ?? Engagement.bilateral;

      // Initalize style
      _style = next.asData?.value.style ?? Style.reps;

      // Initalize base exercises
      final e = next.asData?.value.baseExercise;
      _currentBaseExercise = e;
      _baseExercise = ExerciseBaseExercise(widget.id, e);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<ExerciseEntity?>>(
        exercisesEditControllerProvider(widget.id), (previous, next) {
      next.maybeWhen(
        data: (data) {
          if (previous?.value == null || data == null) return;

          ref.read(exercisesListControllerProvider.notifier).editExercise(data);
          context.pop();
        },
        orElse: () {},
      );
    });

    final variationExercises = ref
        .read(exercisesListControllerProvider.notifier)
        .getBaseExerciseList(baseExerciseId: widget.id);

    final res = ref.watch(exercisesEditControllerProvider(widget.id));

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
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_currentBaseExercise != null)
            SelectionSheet<ExerciseEntity>(
              validator: (value) => _baseExercise?.validate,
              initialValue: _currentBaseExercise,
              hintText: 'Select a base exercise',
              labelText: 'Base Exercise',
              onChanged: (value) {
                _baseExercise = ExerciseBaseExercise(widget.id, value);
              },
              items: variationExercises.asData?.value
                      .map(
                        (e) => DropdownMenuItem(value: e, child: Text(e.name)),
                      )
                      .toList() ??
                  [],
            ),
          MyTextField(
            label: 'Exercise Name',
            hintText: 'Bench Press, Squat, etc.',
            errorText: errorText,
            onChanged: (value) => _name = ExerciseName(value),
            validator: (value) => _name?.validate,
            controller: _nameController,
            readOnly: isLoading,
            isRequired: true,
          ),
          const SizedBox(height: AppLayout.defaultPadding),
          MyTextField(
            label: 'Description',
            hintText:
                'Describe the exercise, including any additional setup that is required.',
            errorText: errorText,
            onChanged: (value) => _description = ExerciseDescription(value),
            validator: (value) => _description?.validate,
            controller: _descriptionController,
            readOnly: isLoading,
            isTextArea: true,
          ),
          const SizedBox(height: AppLayout.defaultPadding),
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
          RadioList<Engagement>(
            selectedValue: _engagement,
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
          RadioList<Style>(
            selectedValue: _style,
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

                    ref
                        .read(
                          exercisesEditControllerProvider(widget.id).notifier,
                        )
                        .handle(
                          _name!,
                          _description!,
                          ExerciseEngagement(
                            _engagement ?? Engagement.bilateral,
                          ),
                          ExerciseStyle(
                            _style ?? Style.reps,
                          ),
                          _baseExercise,
                          _movementPattern!,
                        );
                  },
            child: isLoading
                ? const CircularProgressIndicator()
                : const Text('Save'),
          ),
        ],
      ),
    );
  }
}
