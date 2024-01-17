import 'dart:io';

import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/utils/interfaces.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///
class SelectionSheet<T extends Selectable> extends FormField<T> {
  ///
  SelectionSheet({
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T> onChanged,
    bool canCreate = false,
    bool isRequired = false,
    Widget? createForm,
    String? hintText,
    String? labelText,
    Selectable? initialValue,
    super.key,
    FormFieldValidator<T>? validator,
  }) : super(
          initialValue: initialValue as T?,
          validator: (value) {
            if (isRequired && value == null) {
              return 'This field is required';
            }

            return validator?.call(value);
          },
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
                    const Spacer(),
                    if (isRequired)
                      Text(
                        'Required',
                        style: state.context.textTheme.bodySmall.copyWith(
                          color: state.context.colorScheme.mutedForeground,
                        ),
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
                      selectedItem,
                      canCreate: canCreate,
                    );

                    if (canCreate && createForm != null && res == false) {
                      // ignore: use_build_context_synchronously
                      res = await _showBottomAddSheet(
                        state.context,
                        createForm,
                      );
                    }

                    if (res == null) return;

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

Future<T?> _showBottomSheet<T>(
  BuildContext context,
  List<DropdownMenuItem<T>> items,
  T? selectedValue, {
  bool canCreate = false,
}) {
  return showModalBottomSheet<T>(
    context: context,
    showDragHandle: true,
    scrollControlDisabledMaxHeightRatio: 0.9,
    backgroundColor: context.colorScheme.offBackground,
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    builder: (context) => Stack(
      children: [
        ListView.separated(
          padding: EdgeInsets.only(
            bottom: canCreate
                ? (Platform.isAndroid ? 110 : 64)
                : AppLayout.largePadding,
          ),
          itemCount: items.length,
          separatorBuilder: (context, index) => Divider(
            color: context.colorScheme.divider,
            height: 1,
            indent: 64,
          ),
          itemBuilder: (context, index) {
            final currentItem = items[index];

            return currentItem.child;
          },
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
                  if (canCreate)
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
  Widget createForm,
) {
  return showModalBottomSheet<T>(
    context: context,
    elevation: 0,
    isScrollControlled: true,
    backgroundColor: context.colorScheme.offBackground,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    builder: (context) => Wrap(
      children: [createForm],
    ),
  );
}
