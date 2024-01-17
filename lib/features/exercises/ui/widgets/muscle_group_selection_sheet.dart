import 'package:flex_workout_logger/config/theme/app_layout.dart';
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

                /// Chosen stuff goes
                if (state.value != null && state.value!.isNotEmpty)
                  ...state.value!.map(
                    (e) => Column(
                      children: [
                        CupertinoListTile(
                          title: Text(
                            e.name,
                            overflow: TextOverflow.ellipsis,
                            style: state.context.textTheme.listTitle.copyWith(
                              color: state.context.colorScheme.foreground,
                            ),
                          ),
                          subtitle: Row(
                            children: [
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
                          leading: const Icon(Icons.fitness_center),
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
  final currentItems = selectedItems;

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
                      if (currentItems.isNotEmpty)
                        ...currentItems.map(
                          (e) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: const Icon(Icons.fitness_center, size: 24),
                          ),
                        ),
                      const Spacer(),
                      IconButton.filled(
                        onPressed: () {
                          context.pop(currentItems);
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
                    itemCount: items.length,
                    separatorBuilder: (context, index) => Divider(
                      color: context.colorScheme.divider,
                      height: 1,
                      indent: 64,
                    ),
                    itemBuilder: (context, index) {
                      final currentItem = items[index];

                      return CupertinoListTile(
                        title: Text(
                          currentItem.value?.name ?? 'No Item',
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.listTitle.copyWith(
                            color: context.colorScheme.foreground,
                          ),
                        ),
                        onTap: () {
                          if (currentItems.contains(currentItem.value)) {
                            return;
                          }

                          setState(() {
                            currentItems.add(currentItem.value!);
                          });
                        },
                        leading: const Icon(Icons.fitness_center),
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
                    TextButton(
                      onPressed: () {
                        context.pop(currentItems);
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

  return currentItems;
}
