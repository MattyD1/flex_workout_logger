import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/common/ui/utils/ui_extensions.dart';
import 'package:flex_workout_logger/features/common/ui/widgets/step_indicator.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/exercise_create_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Exercises Detail View Screen
class ExercisesCreateScreen extends ConsumerWidget {
  /// Constructor
  const ExercisesCreateScreen({super.key});

  /// Route name
  static const routeName = 'exercises_create';

  /// Path name where eid is the id of the exercise
  static const routePath = 'exercises/create';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.colorScheme.offBackground,
      appBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.zero,
        backgroundColor: context.colorScheme.offBackground,
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.pop(),
          icon: const Icon(
            CupertinoIcons.xmark,
          ),
          color: context.colorScheme.foreground,
          iconSize: 24,
        ),
        middle: Text(
          'Create Exercise',
          style: TextStyle(color: context.colorScheme.foreground),
        ),
      ),
      body: Stack(
        children: <Widget>[
          const SizedBox.expand(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: AppLayout.defaultPadding,
                vertical: AppLayout.extraLargePadding,
              ),
              child: ExerciseCreateForm(),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(
                left: AppLayout.smallPadding,
                right: AppLayout.smallPadding,
                top: AppLayout.miniPadding,
              ),
              color: context.colorScheme.offBackground,
              child: const StepIndicator(currentStep: 1, totalSteps: 1),
            ),
          ),
        ],
      ),
    );
  }
}
