import 'dart:io';

import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/muscle_group_create_form.dart';
import 'package:flex_workout_logger/utils/interfaces.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

///
class MuscleGroupSelectionSheet<T extends Selectable>
    extends FormField<List<T>> {
  ///
  MuscleGroupSelectionSheet({
    required List<DropdownMenuItem<T>> items,
    super.key,
  }) : super(
          builder: (state) {
            final selectedItems = items
                .where(
                  (element) => state.value?.contains(element.value) ?? false,
                )
                .map((e) => e.value!)
                .toList();

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

                /// Primary muscle groups
                // const SizedBox(height: AppLayout.defaultPadding),
                // const Text('Primary'),
                /// Chosen stuff goes
                if (state.value != null && state.value!.isNotEmpty)
                  ...state.value!.map(
                    (e) => Column(
                      children: [
                        CupertinoListTile(
                          title: Row(
                            children : [
                              const Icon(Icons.fitness_center),
                              const SizedBox(width: AppLayout.defaultPadding),
                              Text (
                                e.name,
                                overflow: TextOverflow.ellipsis,
                                style: state.context.textTheme.listTitle.copyWith(
                                  color: state.context.colorScheme.foreground,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              const SizedBox(width: 44),
                              TextButton(
                                onPressed: () async {},
                                style: TextButton.styleFrom(
                                  // Set minimum size to zero
                                  padding: const EdgeInsets.symmetric(
                                    vertical: AppLayout.miniPadding,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  foregroundColor:
                                      state.context.colorScheme.foreground,
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
                              const SizedBox(
                                width: AppLayout.defaultPadding,
                              ),
                              TextButton(
                                onPressed: () async {
                                  final removeItem = state.value!
                                      .filter((t) => t != e)
                                      .toList();

                                  state.didChange(removeItem);
                                },
                                style: TextButton.styleFrom(
                                  // Set minimum size to zero
                                  padding: const EdgeInsets.symmetric(
                                    vertical: AppLayout.miniPadding,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  foregroundColor:
                                      state.context.colorScheme.foreground,
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

                /// Secondary muscle groups
                // const SizedBox(height: AppLayout.defaultPadding),
                // const Text('Secondary'),


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
                        selectedItems,
                      );

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

Future<List<T>> _showBottomSheet<T extends Selectable>(
  BuildContext context,
  List<DropdownMenuItem<T>> items,
  List<T> selectedItems,
) async {
  final currentItems = items;
  final currentSelectedItems = selectedItems;

  await showModalBottomSheet<List<T>>(
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
                      const SizedBox(width: 8),
                      if (currentSelectedItems.isNotEmpty)
                        ...currentSelectedItems.map(
                          (e) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: const Icon(Icons.fitness_center, size: 24),
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
                    padding: EdgeInsets.only(
                      bottom: Platform.isAndroid ? 110 : 64
                    ),
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
                          if (currentSelectedItems.contains(currentItem.value)) {
                            setState(() {
                              currentSelectedItems.remove(currentItem.value);
                            });
                          } else {
                            setState(() {
                              currentSelectedItems.add(currentItem.value!);
                            });
                          }
                        },
                        leading: const Icon(Icons.fitness_center),
                        trailing: currentSelectedItems.contains(currentItem.value) 
                          ? const Padding(
                            padding: EdgeInsets.only(left: AppLayout.miniPadding),
                            child: Icon(CupertinoIcons.check_mark_circled_solid, size: 16,), 
                          )
                          : const Padding(
                            padding: EdgeInsets.only(left: AppLayout.miniPadding),
                            child: Icon(CupertinoIcons.add_circled, size: 16,),
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
                        final res = await _showBottomAddSheet(context);

                        if (res == null) return;

                        setState(() {
                          currentSelectedItems.add(res as T);
                          currentItems.add(DropdownMenuItem(
                              value: res,
                              child: const Placeholder(),
                          ));
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

Future<T?> _showBottomAddSheet<T extends Selectable>(
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
