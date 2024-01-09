import 'package:realm/realm.dart';

void initializeDatabase(Realm realm, List<RealmObject> data) {
  realm.write(() {
    realm.addAll(data);
  });
}
