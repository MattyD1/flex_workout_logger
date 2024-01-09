import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_create_controller.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_list_controller.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_description.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_name.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
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
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            onChanged: (value) => _name = ExerciseName(value),
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
            decoration: InputDecoration(
              hoverColor: context.colorScheme.foreground,
              hintText: 'Exercise Description',
              errorText: errorText,
            ),
            validator: (value) => _description?.validate,
            readOnly: isLoading,
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
                        .read(exercisesCreateControllerProvider.notifier)
                        .handle(_name!, _description);
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
