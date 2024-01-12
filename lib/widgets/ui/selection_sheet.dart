import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_entity.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/schema.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/exercise_card.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
class SelectionSheet<T extends ExerciseEntity> extends FormField<T> {
  ///
  // ignore: use_super_parameters
  SelectionSheet({
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T> onChanged,
    String? hintText,
    String? labelText,
    Key? key,
    FormFieldValidator<T>? validator,
  }) : super(
          key: key,
          validator: validator,
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
                    final result = await _showBottomSheet(
                      state.context,
                      items,
                      selectedItem,
                    );

                    if (result == null) return;

                    onChanged(result as T);

                    state.didChange(result);
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

Future<T?> _showBottomSheet<T>(
  BuildContext context,
  List<DropdownMenuItem<T>> items,
  T? selectedValue,
) {
  return showModalBottomSheet<T>(
    context: context,
    showDragHandle: true,
    scrollControlDisabledMaxHeightRatio: 0.9,
    backgroundColor: context.colorScheme.offBackground,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    builder: (context) => ListView.separated(
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
            ExerciseListTile(
              exercise: currentItem.value! as ExerciseEntity,
              trailingIcon: CupertinoIcons.add_circled,
              onTap: () {
                Navigator.of(context).pop(currentItem.value);
              },
            ),
          ],
        );
      },
    ),
  );
}
