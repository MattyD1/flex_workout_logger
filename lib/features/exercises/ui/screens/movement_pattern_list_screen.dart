import 'package:flex_workout_logger/features/exercises/ui/widgets/movement_pattern_list.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Library screen
class MovementPatternListScreen extends StatelessWidget {
  /// Constructor
  const MovementPatternListScreen({super.key});

  /// Route name
  static const routeName = 'movement_patterns';

  /// Path name
  static const routePath = 'movement_patterns';

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
            CupertinoIcons.chevron_left,
          ),
          color: context.colorScheme.foreground,
          iconSize: 24,
        ),
        middle: Text(
          'Movement Patterns',
          style: TextStyle(color: context.colorScheme.foreground),
        ),
      ),
      body: const MovementPatternList(),
    );
  }
}
