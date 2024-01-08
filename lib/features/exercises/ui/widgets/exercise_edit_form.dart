import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/common/ui/utils/ui_extensions.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_edit_controller.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_list_controller.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  ExerciseName? _name;

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<ExerciseEntity?>>(
        exercisesEditControllerProvider(widget.id), (previous, next) {
      next.maybeWhen(
        data: (data) {
          if (data == null) return;

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
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppLayout.miniPadding,
              ),
              hoverColor: context.colorScheme.foreground,
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: context
                      .colorScheme.foreground, // Color for Focused Border
                ),
              ),
              hintText: 'Exercise name',
              hintStyle: const TextStyle(
                fontSize: 14,
              ),
              focusColor: context.colorScheme.foreground,
              errorText: errorText,
            ),
            validator: (value) => _name?.validate,
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
                        .read(
                          exercisesEditControllerProvider(widget.id).notifier,
                        )
                        .handle(_name!);
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
