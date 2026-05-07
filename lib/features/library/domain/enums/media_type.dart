enum MediaType {
  anime,
  manga,
  manhwa,
  manhua,
  novel;

  static MediaType fromJson(String value) => MediaType.values.firstWhere(
    (e) => e.name == value,
    orElse: () => throw Exception('Unknown MediaType: $value'),
  );

  String get label => switch (this) {
    MediaType.anime => 'Anime',
    MediaType.manga => 'Manga',
    MediaType.manhwa => 'Manhwa',
    MediaType.manhua => 'Manhua',
    MediaType.novel => 'Novel',
  };
}
