import 'package:flutter/material.dart';

/// A widget that displays an error message
class AppError extends StatelessWidget {
  /// Default constructor
  const AppError({
    required this.title,
    super.key,
    this.description,
  });

  /// Error title displayed on the [AppError]
  final String title;

  /// Error description displayed on the [AppError]
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        const SizedBox(
          height: 30,
        ),
        if (description != null) Text(description!),
      ],
    );
  }
}
