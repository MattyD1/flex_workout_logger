import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/utils/enum_abstract.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/material.dart';

///
class RadioList<T extends Enumeration<Enum>> extends StatelessWidget {
  ///
  const RadioList({
    required this.selectedValue,
    required this.onSelected,
    required this.values,
    required this.groupValue,
    super.key,
  });

  /// The enum values to display
  final List<T> values;

  /// The currently selected value
  final T? selectedValue;

  /// Group value
  final T? groupValue;

  /// The callback when a value is selected
  final ValueChanged<T?> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...values.map(
          (e) => Column(
            children: [
              RadioListTile(
                title: Text(
                  e.name,
                  style: context.textTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: e.description != null
                    ? Text(
                        e.description!,
                        style: context.textTheme.bodySmall,
                      )
                    : null,
                value: e,
                groupValue: groupValue,
                onChanged: onSelected,
                fillColor: MaterialStateColor.resolveWith(
                  (states) {
                    return states.contains(MaterialState.selected)
                        ? context.colorScheme.foreground
                        : context.colorScheme.muted;
                  },
                ),
                controlAffinity: ListTileControlAffinity.trailing,
                contentPadding:
                    const EdgeInsets.only(left: AppLayout.largePadding),
                visualDensity: VisualDensity.compact,
                focusNode: FocusNode(),
              ),
              if (e != values[values.length - 1])
                const Divider(
                  indent: AppLayout.largePadding,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
