import 'dart:async';

import 'package:flex_workout_logger/app.dart';
import 'package:flex_workout_logger/bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

FutureOr<void> main() async {
  runApp(
    UncontrolledProviderScope(
      container: await bootstrap(),
      child: const App(),
    ),
  );
}
