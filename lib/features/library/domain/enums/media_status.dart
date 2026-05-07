enum MediaStatus {
  watching,
  rewatching,
  on_hold,
  dropped,
  completed,
  plan_to_watch;

  static MediaStatus fromJson(String value) => MediaStatus.values.firstWhere(
    (e) => e.name == value,
    orElse: () => throw Exception('Unknown MediaStatus: $value'),
  );

  String get label => switch (this) {
    MediaStatus.watching => 'Watching',
    MediaStatus.rewatching => 'Rewatching',
    MediaStatus.completed => 'Completed',
    MediaStatus.on_hold => 'On Hold',
    MediaStatus.dropped => 'Dropped',
    MediaStatus.plan_to_watch => 'Plan to Watch',
  };
}
