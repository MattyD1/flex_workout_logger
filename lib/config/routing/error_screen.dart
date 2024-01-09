import 'package:flutter/material.dart';

/// Default error page
class ErrorScreen extends StatelessWidget {
  /// Default constructor for the [ErrorScreen]
  const ErrorScreen({required this.message, super.key});

  /// Error message displayed on the [ErrorScreen]
  final String message;

  // TODO: Make it fancy, style it.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(message)),
    );
  }
}
