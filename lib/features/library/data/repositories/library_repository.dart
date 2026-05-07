import 'package:bibliotaku_app/core/network/api_client.dart';
import 'package:bibliotaku_app/features/library/data/models/media_entry_model.dart';
import 'package:bibliotaku_app/features/library/data/models/paginated_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryRepository {
  LibraryRepository(this._dio);
  final Dio _dio;

  Future<PaginatedResponse<MediaEntryModel>> getLibrary({int page = 1}) async {
    final response = await _dio.get(
      '/api/v1/media-entries',
      queryParameters: {'page': page},
    );

    return PaginatedResponse.fromJson(
      Map<String, dynamic>.from(response.data as Map),
      MediaEntryModel.fromJson,
    );
  }
}

final libraryRepositoryProvider = Provider<LibraryRepository>((ref) {
  return LibraryRepository(ref.watch(dioProvider));
});