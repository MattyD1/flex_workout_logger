import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///
class BaseExerciseSelection extends ConsumerStatefulWidget {
  ///
  const BaseExerciseSelection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BaseExerciseSelectionState();
}

class _BaseExerciseSelectionState extends ConsumerState<BaseExerciseSelection> {
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<Widget>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.colorScheme.offBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => SafeArea(
          child: ListView.builder(
            controller: scrollController,
            itemCount: 100,
            itemBuilder: (context, index) => ListTile(
              title: Text(index.toString()),
              onTap: () => Navigator.of(context).pop(index),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('Base Exercise', style: context.textTheme.label),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        TextButton(
          onPressed: () {
            _showBottomSheet(context);
            // showModalBottomSheet(
            //   context: context,
            //   // showDragHandle: true,
            //   // isScrollControlled: true,
            //   backgroundColor: context.colorScheme.offBackground,
            //   builder: (BuildContext context) {
            //     return FractionallySizedBox(
            //         heightFactor: 0.8,
            //         widthFactor: double.infinity,
            //         child: Container(
            //           child: const Text('testing'),
            //         ));
            //   },
            // );
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero, // Set minimum size to zero
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: context.colorScheme.muted,
            ),
            child: Row(
              children: [
                Text(
                  'Select Base Exercise',
                  style: context.textTheme.bodyMedium
                      .copyWith(color: context.colorScheme.mutedForeground),
                ),
                const Spacer(),
                Icon(
                  CupertinoIcons.chevron_down,
                  color: context.colorScheme.mutedForeground,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppLayout.defaultPadding),
      ],
    );
  }
}
