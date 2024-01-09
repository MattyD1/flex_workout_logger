import 'package:flex_workout_logger/widgets/app_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Widet App Error, title, description', () {
    testWidgets('Does title exist', (tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: AppError(title: 'Error')));

      // Create the finders
      final titleFinder = find.text('Error');

      // Assert that the text is correct
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('Does title and description exist', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AppError(title: 'Error', description: 'Error description'),
        ),
      );

      // Create the finders
      final titleFinder = find.text('Error');
      final descriptionFinder = find.text('Error description');

      // Assert that the text is correct
      expect(titleFinder, findsOneWidget);
      expect(descriptionFinder, findsOneWidget);
    });
  });
}
