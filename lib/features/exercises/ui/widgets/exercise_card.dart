import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_delete_controller.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_list_controller.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/ui/screens/exercises_edit_screen.dart';
import 'package:flex_workout_logger/features/exercises/ui/screens/exercises_view_screen.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// A selectable card with [Exercise Title]
class ExercisesCard extends ConsumerWidget {
  ///
  const ExercisesCard({required this.exercise, super.key});

  /// The exercise the card represents
  final ExerciseEntity exercise;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoListTile(
      title: Text(
        exercise.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.listTitle.copyWith(
          color: context.colorScheme.foreground,
        ),
      ),
      subtitle: Row(
        children: <Widget>[
          Text(
            'Movement Pattern',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.listSubtitle.copyWith(
              color: context.colorScheme.offForeground,
            ),
          ),
          const SizedBox(width: AppLayout.defaultPadding),
          Expanded(
            child: Text(
              'List of Muscle Groups jlikjdaldjaflfijealjkj',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.listSubtitle.copyWith(
                color: context.colorScheme.offForeground,
              ),
            ),
          ),
        ],
      ),
      onTap: () => context.goNamed(
        ExercisesViewScreen.routeName,
        pathParameters: {
          'eid': exercise.id,
        },
      ),
      leading: const Icon(Icons.fitness_center),
      trailing: const Padding(
        padding: EdgeInsets.only(left: AppLayout.miniPadding),
        child: Icon(
          CupertinoIcons.info_circle,
          size: 16,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(
        20,
        16,
        14,
        16,
      ),
    );
  }
}

// trailing: Row(
//         children: [
//           IconButton(
//             onPressed: () => context.goNamed(
//               ExercisesEditScreen.routeName,
//               pathParameters: {
//                 'eid': exercise.id,
//               },
//             ),
//             icon: const Icon(
//               CupertinoIcons.pencil,
//             ),
//             iconSize: 20,
//           ),
//           IconButton(
//             onPressed: () => {
//               showDialog<void>(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: const Text('Are you sure about that?'),
//                     content: const Text('This will delete the exercise'),
//                     actions: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         child: const Text('Cancel'),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           ref
//                               .read(
//                                   exercisesDeleteControllerProvider(exercise.id)
//                                       .notifier)
//                               .handle();

//                           ref
//                               .read(exercisesListControllerProvider.notifier)
//                               .deleteExercise(exercise);

//                           Navigator.of(context).pop();
//                         },
//                         child: const Text('Confirm'),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             },
//             icon: const Icon(
//               CupertinoIcons.trash,
//             ),
//             iconSize: 20,
//           ),
//         ],
     