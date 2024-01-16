import 'package:faker/faker.dart';
import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern_entity.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/movement_pattern_quick_create_form.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

///
class MovementPatternSelectionSheet<T extends MovementPatternEntity>
    extends FormField<T> {
  ///
  // ignore: use_super_parameters
  MovementPatternSelectionSheet({
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T> onChanged,
    String? hintText,
    String? labelText,
    T? initialValue,
    Key? key,
    FormFieldValidator<T>? validator,
  }) : super(
          key: key,
          validator: validator,
          initialValue: initialValue,
          builder: (state) {
            final selectedItem =
                items.where((element) => element.value == state.value).toList();

            return Column(
              children: [
                Row(
                  children: [
                    Text(
                      labelText ?? 'Select',
                      style: state.context.textTheme.label,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                TextButton(
                  onPressed: () async {
                    var res = await _showBottomSheet(
                      state.context,
                      items,
                    );

                    if (res == false) {
                      res = await _showBottomAddSheet(
                        state.context,
                      );
                    }

                    if (res == null) return;

                    debugPrint('result: $res');

                    onChanged(res as T);

                    state.didChange(res);
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
                      color: state.hasError
                          ? Theme.of(state.context)
                              .colorScheme
                              .error
                              .withOpacity(0.5)
                          : state.context.colorScheme.muted,
                    ),
                    child: Row(
                      children: [
                        if (selectedItem.isNotEmpty)
                          Text(
                            selectedItem[0].value?.name ??
                                'Something went wrong',
                            style: state.context.textTheme.bodyMedium.copyWith(
                              color: state.context.colorScheme.foreground,
                            ),
                          )
                        else
                          Text(
                            hintText ?? 'Select an option',
                            style: state.context.textTheme.bodyMedium.copyWith(
                              color: state.context.colorScheme.mutedForeground,
                            ),
                          ),
                        const Spacer(),
                        Icon(
                          CupertinoIcons.chevron_down,
                          color: state.context.colorScheme.mutedForeground,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                if (state.hasError)
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          state.errorText ?? 'Invalid field',
                          style: TextStyle(
                            fontSize: Theme.of(state.context)
                                .textTheme
                                .bodySmall
                                ?.fontSize,
                            color: Theme.of(state.context).colorScheme.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: AppLayout.defaultPadding),
              ],
            );
          },
        );
}

Future<dynamic> _showBottomSheet<T>(
  BuildContext context,
  List<DropdownMenuItem<T>> items,
) {
  return showModalBottomSheet<dynamic>(
    context: context,
    showDragHandle: true,
    elevation: 0,
    scrollControlDisabledMaxHeightRatio: 0.9,
    backgroundColor: context.colorScheme.offBackground,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    builder: (context) => Stack(
      children: [
        ListView.separated(
          padding: const EdgeInsets.only(bottom: 110),
          itemCount: items.length,
          separatorBuilder: (context, index) => Divider(
            color: context.colorScheme.divider,
            height: 1,
            indent: 64,
          ),
          itemBuilder: (context, index) {
            final currentItem = items[index];

            return Column(
              children: [
                CupertinoListTile(
                  title: Text(
                    (currentItem.value! as MovementPatternEntity).name,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.listTitle.copyWith(
                      color: context.colorScheme.foreground,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(currentItem.value);
                  },
                  leading: const Icon(Icons.fitness_center),
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    16,
                    14,
                    16,
                  ),
                ),
              ],
            );
          },
        ),
        Positioned(
          bottom: 0,
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
                    onPressed: () {
                      context.pop(false);
                    },
                    icon: const Icon(
                      CupertinoIcons.add,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: context.colorScheme.foreground,
                      foregroundColor: context.colorScheme.background,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
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
      children: [MovementPatternQuickCreateForm()],
    ),
  );
}
