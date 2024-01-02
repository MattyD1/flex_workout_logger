import 'flavors.dart';

import 'main.dart' as runner;

/// To run the app with the production flavor, run the following command:
/// flutter run --flavor production --target lib/main_production.dart
Future<void> main() async {
  F.appFlavor = Flavor.production;
  await runner.main();
}
