import 'package:flex_workout_logger/utils/interfaces.dart';
import 'package:realm/realm.dart';

/// Returns a Realm schema from an entity
Schema? getRealmObjectFromEntity<Entity extends DatabaseEntity,
    Schema extends RealmObject>(
  Realm realm,
  Entity? entity,
) {
  // ignore: avoid_init_to_null
  late Schema? schema = null;

  if (entity != null) {
    final objectId = ObjectId.fromHexString(entity.id);

    schema = realm.find<Schema>(objectId);
  }

  return schema;
}

/// Returns a Realm schema list from an entity
RealmResults<Schema> getRealmResultsFromEntityList<
    Entity extends DatabaseEntity, Schema extends RealmObject>(
  Realm realm,
  List<Entity> entities,
) {
  final entityIds = entities.map((e) => ObjectId.fromHexString(e.id)).toList();

  // ignore: use_raw_strings
  final queryRes = realm.query<Schema>('id IN \$0', [entityIds]);

  return queryRes;
}
