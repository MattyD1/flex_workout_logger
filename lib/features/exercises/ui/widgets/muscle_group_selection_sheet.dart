import 'dart:io';

import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/muscle_groups_primary_and_secondary.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/muscle_group_create_form.dart';
import 'package:flex_workout_logger/utils/interfaces.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///
class MuscleGroupSelectionSheet<T extends Selectable>
    extends FormField<Map<MuscleGroupPriority, List<T>>> {
  ///
  MuscleGroupSelectionSheet({
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<Map<MuscleGroupPriority, List<T>>> onChanged,
    super.key,
    super.initialValue,
    super.validator,
  }) : super(
          builder: (state) {
            final initalPrimary = <T>[];
            final initalSecondary = <T>[];
            initalPrimary.addAll(state.value!.entries.first.value);
            initalSecondary.addAll(state.value!.entries.last.value);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Muscle Groups',
                      style: state.context.textTheme.label,
                    ),
                    const Text(
                      'What muscle groups are used in this exercise?',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),

                if (state.value != null && state.value!.entries.first.value.isNotEmpty)
                  ...state.value!.entries.map(
                    (e) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppLayout.defaultPadding),
                        Text(e.key == MuscleGroupPriority.primary ? 'Primary' : 'Secondary'),
                        ...e.value.map(
                          (f) => Column(
                            children: [
                              CupertinoListTile(
                                title: Row(
                                  children: [
                                    const Icon(Icons.fitness_center),
                                    const SizedBox(
                                        width: AppLayout.defaultPadding),
                                    Text(
                                      f.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: state.context.textTheme.listTitle
                                          .copyWith(
                                        color: state
                                            .context.colorScheme.foreground,
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    const SizedBox(width: 44),
                                    if (e.key == MuscleGroupPriority.primary)
                                      TextButton(
                                        onPressed: () async {
                                          initalPrimary.remove(f);
                                          initalSecondary.add(f);

                                          final res = {
                                            MuscleGroupPriority.primary: initalPrimary,
                                            MuscleGroupPriority.secondary: initalSecondary,
                                          };

                                          onChanged(res);
                                          
                                          state.didChange(res);
                                        },
                                        style: TextButton.styleFrom(
                                          // Set minimum size to zero
                                          padding: const EdgeInsets.symmetric(
                                            vertical: AppLayout.miniPadding,
                                          ),
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: state
                                              .context.colorScheme.foreground,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              CupertinoIcons.minus_circle,
                                              size: 16,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              'Remove as primary',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: state.context.colorScheme
                                                    .mutedForeground,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (e.key == MuscleGroupPriority.secondary)
                                      TextButton(
                                        onPressed: () async {
                                          initalPrimary.add(f);
                                          initalSecondary.remove(f);

                                          final res = {
                                            MuscleGroupPriority.primary: initalPrimary,
                                            MuscleGroupPriority.secondary: initalSecondary,
                                          };

                                          onChanged(res);
                                          
                                          state.didChange(res);
                                        },
                                        style: TextButton.styleFrom(
                                          // Set minimum size to zero
                                          padding: const EdgeInsets.symmetric(
                                            vertical: AppLayout.miniPadding,
                                          ),
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: state
                                              .context.colorScheme.foreground,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              CupertinoIcons.plus_circle,
                                              size: 16,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              'Add as primary',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: state.context.colorScheme
                                                    .mutedForeground,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    const SizedBox(
                                      width: AppLayout.defaultPadding,
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        if(initalPrimary.contains(f)){
                                          initalPrimary.remove(f);
                                        }
                                        if(initalSecondary.contains(f)){
                                          initalSecondary.remove(f);
                                        }

                                        final res = {
                                          MuscleGroupPriority.primary: initalPrimary,
                                          MuscleGroupPriority.secondary: initalSecondary,
                                        };

                                        onChanged(res);

                                        state.didChange(res);
                                      },
                                      style: TextButton.styleFrom(
                                        // Set minimum size to zero
                                        padding: const EdgeInsets.symmetric(
                                          vertical: AppLayout.miniPadding,
                                        ),
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: state
                                            .context.colorScheme.foreground,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            CupertinoIcons.minus_circle,
                                            size: 16,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            'Remove',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: state.context.colorScheme
                                                  .mutedForeground,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.only(
                                  left: 4,
                                  top: 16,
                                ),
                              ),
                              Divider(
                                color: state.context.colorScheme.divider,
                                height: 1,
                                indent: 48,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                /// Add button
                const SizedBox(
                  height: AppLayout.defaultPadding,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () async {
                      final res = await _showBottomSheet<T>(
                        state.context,
                        items,
                        {
                          MuscleGroupPriority.primary: initalPrimary,
                          MuscleGroupPriority.secondary: initalSecondary,
                        },
                      );

                      onChanged(res);

                      state.didChange(res);
                    },
                    style: TextButton.styleFrom(
                      // Set minimum size to zero
                      padding: const EdgeInsets.symmetric(
                        vertical: AppLayout.miniPadding,
                        horizontal: AppLayout.defaultPadding,
                      ),
                      backgroundColor: state.context.colorScheme.muted,
                      foregroundColor: state.context.colorScheme.foreground,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.add,
                          size: 20,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Add Muscle Group'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppLayout.defaultPadding,
                ),
                Divider(
                  color: state.context.colorScheme.divider,
                  thickness: 1,
                ),
              ],
            );
          },
        );
}

Future<Map<MuscleGroupPriority, List<T>>>
    _showBottomSheet<T extends Selectable>(
  BuildContext context,
  List<DropdownMenuItem<T>> items,
  Map<MuscleGroupPriority, List<T>> selectedItems,
) async {
  final currentItems = items;
  final currentSelectedItems = selectedItems;

  final primaryMuscleGroups =
      currentSelectedItems[MuscleGroupPriority.primary] ?? <T>[];
  final secondaryMuscleGroups =
      currentSelectedItems[MuscleGroupPriority.secondary] ?? <T>[];

  await showModalBottomSheet<Map<MuscleGroupPriority, List<T>>>(
    context: context,
    scrollControlDisabledMaxHeightRatio: 1,
    useSafeArea: true,
    backgroundColor: context.colorScheme.background,
    barrierColor: context.colorScheme.background,
    elevation: 0,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Row for selected items
              Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.background,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: AppLayout.miniPadding,
                  horizontal: AppLayout.miniPadding,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colorScheme.offBackground,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(999),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Selected items
                      if (primaryMuscleGroups.isNotEmpty)
                        ...primaryMuscleGroups.map(
                          (e) => Container(
                            decoration: BoxDecoration(
                              color: context.colorScheme.muted,
                              shape: BoxShape.circle,
                            ),
                            padding:
                                const EdgeInsets.all(AppLayout.smallPadding),
                            // padding: const EdgeInsets.symmetric(horizontal: 1),
                            child: Icon(
                              Icons.fitness_center_rounded,
                              size: 24,
                              color: context.colorScheme.foreground,
                            ),
                          ),
                        ),
                      if (secondaryMuscleGroups.isNotEmpty)
                        ...secondaryMuscleGroups.map(
                          (e) => Container(
                            padding:
                                const EdgeInsets.all(AppLayout.smallPadding),
                            // padding: const EdgeInsets.symmetric(horizontal: 1),
                            child: Icon(
                              Icons.fitness_center_rounded,
                              size: 24,
                              color: context.colorScheme.foreground,
                            ),
                          ),
                        ),
                      const Spacer(),
                      IconButton.filled(
                        onPressed: () {
                          context.pop(currentSelectedItems);
                        },
                        style: IconButton.styleFrom(
                          padding: const EdgeInsets.all(AppLayout.smallPadding),
                          backgroundColor: context.colorScheme.muted,
                          foregroundColor: context.colorScheme.foreground,
                        ),
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          size: 29,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Divider
              Container(
                height: kMinInteractiveDimension,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.colorScheme.offBackground,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                ),
                child: Center(
                  child: Container(
                    height: 4,
                    width: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32 / 2),
                      color: context.colorScheme.foreground.withOpacity(0.4),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ColoredBox(
                  color: context.colorScheme.offBackground,
                  child: ListView.separated(
                    padding:
                        EdgeInsets.only(bottom: Platform.isAndroid ? 110 : 64),
                    itemCount: currentItems.length,
                    separatorBuilder: (context, index) => Divider(
                      color: context.colorScheme.divider,
                      height: 1,
                      indent: 64,
                    ),
                    itemBuilder: (context, index) {
                      final currentItem = currentItems[index];

                      return CupertinoListTile(
                        title: Text(
                          currentItem.value?.name ?? 'No Item',
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.listTitle.copyWith(
                            color: context.colorScheme.foreground,
                          ),
                        ),
                        onTap: () {
                          if (primaryMuscleGroups.contains(currentItem.value)){
                            setState(() {
                              currentSelectedItems[MuscleGroupPriority.primary]
                                  ?.remove(currentItem.value!);
                            });
                            return;
                          }
                          if(secondaryMuscleGroups.contains(currentItem.value)) {
                            setState(() {
                              currentSelectedItems[MuscleGroupPriority.secondary]
                                  ?.remove(currentItem.value!);
                            });
                            return;
                          }

                          if (primaryMuscleGroups.isEmpty) {
                            setState(() {
                              currentSelectedItems[MuscleGroupPriority.primary]
                                  ?.add(currentItem.value!);
                            });
                            return;
                          }

                          setState(() {
                            currentSelectedItems[MuscleGroupPriority.secondary]
                                ?.add(currentItem.value!);
                          });
                        },
                        leading: const Icon(Icons.fitness_center),
                        trailing: primaryMuscleGroups.contains(currentItem.value) || secondaryMuscleGroups.contains(currentItem.value)
                                ? const Padding(
                                    padding: EdgeInsets.only(
                                        left: AppLayout.miniPadding),
                                    child: Icon(
                                      CupertinoIcons.check_mark_circled_solid,
                                      size: 16,
                                    ),
                                  )
                                : const Padding(
                                    padding: EdgeInsets.only(
                                        left: AppLayout.miniPadding),
                                    child: Icon(
                                      CupertinoIcons.add_circled,
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
                    },
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    context.colorScheme.offBackground.withOpacity(0),
                    context.colorScheme.offBackground,
                  ],
                  stops: const [
                    0,
                    0.65,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: AppLayout.defaultPadding,
                  right: AppLayout.defaultPadding,
                  bottom: 44,
                  top: AppLayout.smallPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton.filled(
                      onPressed: () async {
                        final res = await _showBottomAddSheet<T>(context);

                        if (res == null) return;

                        currentItems.add(
                          DropdownMenuItem(
                            value: res,
                            child: const Placeholder(),
                          ),
                        );

                        setState(() {
                          if (primaryMuscleGroups.contains(res) ||
                              secondaryMuscleGroups.contains(res)) {
                            return;
                          }

                          if (primaryMuscleGroups.isEmpty) {
                            setState(() {
                              currentSelectedItems[MuscleGroupPriority.primary]
                                  ?.add(res);
                            });
                            return;
                          }

                          setState(() {
                            currentSelectedItems[MuscleGroupPriority.secondary]
                                ?.add(res);
                          });
                        });
                      },
                      icon: const Icon(
                        CupertinoIcons.add,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: context.colorScheme.muted,
                        foregroundColor: context.colorScheme.foreground,
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        context.pop(currentSelectedItems);
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: context.colorScheme.foreground,
                        foregroundColor: context.colorScheme.background,
                      ),
                      child: const Text('Done'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  return currentSelectedItems;
}

Future<T?> _showBottomAddSheet<T>(
  BuildContext context,
) {
  return showModalBottomSheet<T>(
    context: context,
    elevation: 0,
    isScrollControlled: true,
    backgroundColor: context.colorScheme.offBackground,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    builder: (context) => const Wrap(
      children: [MuscleGroupCreateForm()],
    ),
  );
}
