import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_view_controller.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/exercise_view.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flex_workout_logger/widgets/app_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Exercises Detail View Screen
class ExercisesViewScreen extends ConsumerWidget {
  /// Constructor
  const ExercisesViewScreen({required this.id, super.key});

  /// Exercise id
  final String id;

  /// Route name
  static const routeName = 'exercises_view';

  /// Path name where eid is the id of the exercise
  static const routePath = 'exercises/:eid';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercise = ref.watch(exercisesViewControllerProvider(id));

    return Scaffold(
      backgroundColor: context.colorScheme.offBackground,
      appBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.zero,
        backgroundColor: context.colorScheme.offBackground,
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
          color: context.colorScheme.foreground,
          iconSize: 29,
        ),
        middle: exercise.when(
          data: (data) => Text(
            data.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: context.colorScheme.foreground),
          ),
          error: (error, stackTrace) => const Text('Error'),
          loading: () => const Text(''),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: AppLayout.defaultPadding,
          right: AppLayout.defaultPadding,
          top: AppLayout.defaultPadding,
        ),
        child: CustomScrollView(
          scrollBehavior: const CupertinoScrollBehavior(),
          slivers: <Widget>[
            exercise.when(
              data: (data) => SliverToBoxAdapter(
                child: ExerciseView(exercise: data),
              ),
              error: (o, e) => SliverToBoxAdapter(
                child: AppError(
                  title: o.toString(),
                ),
              ),
              loading: () => const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
