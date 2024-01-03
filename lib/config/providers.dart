import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

///
/// Infrastructure providers
///

/// Exposes [Realm] instance
@riverpod
Future<Realm> realm(RealmRef ref) async {
  final config = Configuration.local([]);
  return Realm(config);
}

/// Exposes [Realm] for the client
@riverpod
Realm realmClient(RealmClientRef ref) {
  return ref.watch(realmProvider).value!;
}

/// Triggered from the boostrap to ensure the futures are complete
Future<void> initializeProviders(ProviderContainer container) async {
  /// Core
  await container.read(realmProvider.future);
}
