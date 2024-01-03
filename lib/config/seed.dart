import 'package:flex_workout_logger/features/common/infrastructure/schemas/test_realm_model.dart';
import 'package:realm/realm.dart';

/// Seeds the realm with data on first load
void realmSeed(Realm realm) {
  realm.add(
    Car(ObjectId(), 'Ford'),
  );
}
