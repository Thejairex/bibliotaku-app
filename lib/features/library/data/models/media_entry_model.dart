import 'package:bibliotaku_app/features/library/domain/enums/media_status.dart';
import 'package:bibliotaku_app/features/library/domain/enums/media_type.dart';

import '../../domain/entities/media_entry.dart';

class MediaEntryModel {
  final int id;
  final String title;
  final String? originalTitle;
  final MediaType type;
  final MediaStatus status;
  final String? coverUrl;
  final int? currentEpisode;
  final int? totalEpisodes;
  final int? currentChapter;
  final int? totalChapters;
  final int? currentVolume;
  final int? totalVolumes;
  final int? rating;
  final String? notes;

  const MediaEntryModel({
    required this.id,
    required this.title,
    this.originalTitle,
    required this.type,
    required this.status,
    this.coverUrl,
    this.currentEpisode,
    this.totalEpisodes,
    this.currentChapter,
    this.totalChapters,
    this.currentVolume,
    this.totalVolumes,
    this.rating,
    this.notes,
  });

  factory MediaEntryModel.fromJson(Map<String, dynamic> json) {
    return MediaEntryModel(
      id:             json['id'] as int,
      title:          json['title'] as String,
      originalTitle:  json['original_title'] as String?,
      type:           MediaType.values.byName(json['type'] as String),
      status:         MediaStatus.values.byName(json['status'] as String),
      coverUrl:       json['cover_url'] as String?,
      currentEpisode: json['current_episode'] as int?,
      totalEpisodes:  json['total_episodes'] as int?,
      currentChapter: json['current_chapter'] as int?,
      totalChapters:  json['total_chapters'] as int?,
      currentVolume:  json['current_volume'] as int?,
      totalVolumes:   json['total_volumes'] as int?,
      rating:         json['rating'] as int?,
      notes:          json['notes'] as String?,
    );
  }
}