import 'flavors.dart';

import 'main.dart' as runner;

/// To run the app with the development flavor, run the following command:
/// flutter run --flavor development --target lib/main_development.dart
Future<void> main() async {
  F.appFlavor = Flavor.development;
  await runner.main();
}
