import 'package:flex_workout_logger/features/common/ui/utils/ui_extensions.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/exercises_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Library screen
class LibraryScreen extends StatelessWidget {
  /// Constructor
  const LibraryScreen({super.key});

  /// Route name
  static const routeName = 'library';

  /// Path name
  static const routePath = 'library';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      body: CustomScrollView(
        scrollBehavior: const CupertinoScrollBehavior(),
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text(
              'Library',
              style: TextStyle(color: context.colorScheme.foreground),
            ),
            backgroundColor: context.colorScheme.offBackground,
            border: null,
          ),
          const SliverToBoxAdapter(child: ExercisesList()),
        ],
      ),
    );
  }
}
