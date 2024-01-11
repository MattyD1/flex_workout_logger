import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/material.dart';

///
class IconTextButton extends StatelessWidget {
  ///
  const IconTextButton({
    required this.icon,
    required this.text,
    required this.onPressed,
    super.key,
  });

  /// Icon
  final IconData icon;

  /// Text
  final String text;

  /// OnPressed
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero, // Set minimum size to zero
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
      child: Column(
        children: [
          Ink(
            padding: const EdgeInsets.all(8),
            decoration: ShapeDecoration(
              color: context.colorScheme.muted,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
            child: Icon(
              icon,
              color: context.colorScheme.foreground,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            text,
            style: context.textTheme.bodySmall.copyWith(
              color: context.colorScheme.foreground,
            ),
          ),
        ],
      ),
    );
  }
}
