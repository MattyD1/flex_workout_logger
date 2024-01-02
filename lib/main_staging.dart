import 'flavors.dart';

import 'main.dart' as runner;

/// To run the app with the production flavor, run the following command:
/// flutter run --flavor staging --target lib/main_staging.dart
Future<void> main() async {
  F.appFlavor = Flavor.staging;
  await runner.main();
}
