enum MediaStatus {
  watching,
  rewatching,
  on_hold,
  dropped,
  plan_to_watch;

  static MediaStatus fromJson(String value) =>
      MediaStatus.values.firstWhere((e) => e.name == value);

  String get label => switch (this) {
    MediaStatus.watching => 'Watching',
    MediaStatus.rewatching => 'Rewatching',
    MediaStatus.on_hold => 'On Hold',
    MediaStatus.dropped => 'Dropped',
    MediaStatus.plan_to_watch => 'Plan to Watch',
  };
}
