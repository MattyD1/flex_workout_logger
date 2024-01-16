import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/controllers/movement_pattern_create_controller.dart';
import 'package:flex_workout_logger/features/exercises/controllers/movement_pattern_list_controller.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/movement_pattern_name.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flex_workout_logger/widgets/ui/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

///
class MovementPatternCreateForm extends ConsumerStatefulWidget {
  ///
  const MovementPatternCreateForm({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MovementPatternCreateFormState();
}

class _MovementPatternCreateFormState
    extends ConsumerState<MovementPatternCreateForm> {
  final _formKey = GlobalKey<FormState>();

  MovementPatternName? _name;

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<MovementPatternEntity?>>(
        movementPatternCreateControllerProvider, (previous, next) {
      next.maybeWhen(
        data: (data) {
          if (data == null) return;

          ref
              .read(movementPatternListControllerProvider.notifier)
              .addMovementPattern(data);

          context.pop(data);
        },
        orElse: () {},
      );
    });

    final res = ref.watch(movementPatternCreateControllerProvider);
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
      child: Padding(
        padding: EdgeInsets.only(
          left: AppLayout.defaultPadding,
          right: AppLayout.defaultPadding,
          bottom: 44 + MediaQuery.of(context).viewInsets.bottom,
          top: AppLayout.smallPadding,
        ),
        child: Column(
          children: [
            // headings
            Row(
              children: [
                IconButton.filled(
                  onPressed: () {
                    debugPrint('close');
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.close,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: context.colorScheme.muted,
                    foregroundColor: context.colorScheme.foreground,
                  ),
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(
                      'Create',
                      style: context.textTheme.bodyMedium.copyWith(
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                    Text(
                      'Movement Pattern',
                      style: context.textTheme.headlineLarge.copyWith(
                        color: context.colorScheme.foreground,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton.filled(
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }

                          if (_name == null) return;

                          await ref
                              .read(
                                movementPatternCreateControllerProvider
                                    .notifier,
                              )
                              .handle(_name!, null);
                        },
                  icon: const Icon(
                    Icons.check,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: context.colorScheme.foreground,
                    foregroundColor: context.colorScheme.background,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // TextFields
            MyTextField(
              label: 'Movement Pattern Name',
              hintText: 'Horizontal Push, Vertical Pull, etc...',
              errorText: errorText,
              onChanged: (value) => _name = MovementPatternName(value),
              validator: (value) => _name?.validate,
              controller: null,
              readOnly: isLoading,
              isRequired: true,
            ),
          ],
        ),
      ),
    );
  }
}
