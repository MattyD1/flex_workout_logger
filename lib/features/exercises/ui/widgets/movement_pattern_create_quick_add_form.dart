import 'package:flex_workout_logger/features/exercises/controllers/movement_pattern_create_controller.dart';
import 'package:flex_workout_logger/features/exercises/controllers/movement_pattern_list_controller.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern_entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/movement_pattern_description.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/movement_pattern_name.dart';
import 'package:flex_workout_logger/widgets/ui/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

///
class MovementPatternCreateQuickAddForm extends ConsumerStatefulWidget {
  ///
  const MovementPatternCreateQuickAddForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovementPatternCreateQuickAddFormState();
}

class _MovementPatternCreateQuickAddFormState extends ConsumerState<MovementPatternCreateQuickAddForm> {
  final _formKey = GlobalKey<FormState>();
  
  MovementPatternName? _name;
  MovementPatternDescription? _description;

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<MovementPatternEntity?>>(movementPatternCreateControllerProvider,
        (previous, next) {
      next.maybeWhen(
        data: (data) {
          if (data == null) return;

          ref.read(movementPatternListControllerProvider.notifier).addMovementPattern(data);
          context.pop();
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column (
        children: [
          // headings
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
    );
  }
}