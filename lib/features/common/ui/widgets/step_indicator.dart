import 'package:flex_workout_logger/features/common/ui/utils/ui_extensions.dart';
import 'package:flutter/material.dart';

/// A step indicator
class StepIndicator extends StatelessWidget {
  /// Constructor
  const StepIndicator({
    required this.currentStep,
    required this.totalSteps,
    super.key,
  });

  /// The current step
  final int currentStep;

  /// The total steps
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalSteps,
        (index) => Expanded(
          child: Container(
            height: 3, // Height of the rectangle
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: index < currentStep
                  ? context.colorScheme.foreground
                  : context.colorScheme.muted,
            ),
          ),
        ),
      ),
    );
  }
}
