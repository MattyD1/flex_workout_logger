import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/exercise_edit_form.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Exercises Detail View Screen
class ExercisesEditScreen extends StatelessWidget {
  /// Constructor
  const ExercisesEditScreen({required this.id, super.key});

  /// Exercise id
  final String id;

  /// Route name
  static const routeName = 'exercises_edit';

  /// Path name where eid is the id of the exercise
  static const routePath = 'exercises/:eid/edit';

  @override
  Widget build(BuildContext context) {
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
          'Edit Exercise $id',
          style: TextStyle(color: context.colorScheme.foreground),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: AppLayout.defaultPadding,
                vertical: AppLayout.extraLargePadding,
              ),
              child: ExerciseEditForm(
                id: id,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
