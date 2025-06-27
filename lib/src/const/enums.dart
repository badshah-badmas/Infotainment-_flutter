
enum StopItemPosition { first, middle, last }

enum StopPositionStage {
  /// The bus has already passed this stop some time ago.
  passed,

  /// This is the next stop the bus will arrive at; the bus is approaching it.
  approaching,

  /// The bus is currently at this stop.
  atStop,

  /// This stop is on the route but not the immediate next one; it is further ahead.
  upcoming,
}
