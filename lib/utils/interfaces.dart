/// Interface for selectable items
mixin Selectable {
  /// Name of the item to show when selected
  String get name;
}

/// Interface for database entities
mixin DatabaseEntity {
  /// Unique identifier of the entity
  String get id;
}
