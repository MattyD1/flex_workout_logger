import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_edit_controller.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_list_controller.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_description.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_engagement.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_name.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_style.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
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
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  ExerciseName? _name;
  ExerciseDescription? _description;
  Engagement? _engagement;
  Style? _style;

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
          TextFormField(
            onChanged: (value) => _name = ExerciseName(value),
            controller: _nameController,
            decoration: InputDecoration(
              hoverColor: context.colorScheme.foreground,
              hintText: 'Exercise name',
              errorText: errorText,
            ),
            validator: (value) => _name?.validate,
            readOnly: isLoading,
          ),
          TextFormField(
            onChanged: (value) => _description = ExerciseDescription(value),
            controller: _descriptionController,
            decoration: InputDecoration(
              hoverColor: context.colorScheme.foreground,
              hintText: 'Exercise description',
              errorText: errorText,
            ),
            validator: (value) => _description?.validate,
            readOnly: isLoading,
          ),
          const SizedBox(height: AppLayout.defaultPadding),
          const Text('Engagement'),
          RadioListTile<Engagement>(
            title: const Text('Biliateral'),
            value: Engagement.bilateral, 
            groupValue: _engagement, 
            onChanged: (Engagement? value) {
              setState(() {
                _engagement = value;
              });
            },
          ),
          RadioListTile<Engagement>(
            title: const Text('Biliateral Exercises With Separate Weights'),
            value: Engagement.bilateralSeparate, 
            groupValue: _engagement, 
            onChanged: (Engagement? value) {
              setState(() {
                _engagement = value;
              });
            },
          ),
          RadioListTile<Engagement>(
            title: const Text('Unilateral'),
            value: Engagement.unilateral, 
            groupValue: _engagement, 
            onChanged: (Engagement? value) {
              setState(() {
                _engagement = value;
              });
            },
          ),
          const SizedBox(height: AppLayout.defaultPadding),
          const Text('Style'),
          RadioListTile<Style>(
            title: const Text('Reps'),
            value: Style.reps, 
            groupValue: _style, 
            onChanged: (Style? value) {
              setState(() {
                _style = value;
              });
            }
          ),
          RadioListTile<Style>(
            title: const Text('Timed'),
            value: Style.timed, 
            groupValue: _style, 
            onChanged: (Style? value) {
              setState(() {
                _style = value;
              });
            }
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
                        .handle(_name!, _description!, ExerciseEngagement(_engagement ?? Engagement.bilateral), ExerciseStyle(_style ?? Style.reps)); // FIX: engagement should not be hardcoded
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
