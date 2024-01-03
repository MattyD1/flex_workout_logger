import 'package:flex_workout_logger/config/providers.dart';
import 'package:flex_workout_logger/features/common/infrastructure/schemas/test_realm_model.dart';
import 'package:flex_workout_logger/features/common/ui/utils/ui_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Example List
class ExampleList extends ConsumerWidget {
  /// Example List Constructor
  const ExampleList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final realm = ref.watch(realmClientProvider);

    final cars = realm.all<Car>();

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 100),
          Text(context.tr.appName),
          ...cars.map(
            (car) => Text(car.make),
          ),
        ],
      ),
    );
  }
}
