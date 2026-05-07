// lib/features/library/domain/providers/library_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/paginated_response.dart';
import '../../data/models/media_entry_model.dart';
import '../../data/repositories/library_repository.dart';

class LibraryState {
  final List<MediaEntryModel> items;
  final int currentPage;
  final int lastPage;
  final bool isLoadingMore;

  const LibraryState({
    this.items = const [],
    this.currentPage = 1,
    this.lastPage = 1,
    this.isLoadingMore = false,
  });

  bool get hasMore => currentPage < lastPage;

  LibraryState copyWith({
    List<MediaEntryModel>? items,
    int? currentPage,
    int? lastPage,
    bool? isLoadingMore,
  }) {
    return LibraryState(
      items:         items ?? this.items,
      currentPage:   currentPage ?? this.currentPage,
      lastPage:      lastPage ?? this.lastPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class LibraryNotifier extends AsyncNotifier<LibraryState> {
  @override
  Future<LibraryState> build() async {
    return _fetchPage(1);
  }

  Future<LibraryState> _fetchPage(int page) async {
    final repo = ref.read(libraryRepositoryProvider);
    final result = await repo.getLibrary(page: page);
    return LibraryState(
      items:       result.data,
      currentPage: result.currentPage,
      lastPage:    result.lastPage,
    );
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final repo = ref.read(libraryRepositoryProvider);
      final result = await repo.getLibrary(page: current.currentPage + 1);
      state = AsyncData(current.copyWith(
        items:         [...current.items, ...result.data],
        currentPage:   result.currentPage,
        lastPage:      result.lastPage,
        isLoadingMore: false,
      ));
    } catch (e, st) {
      state = AsyncData(current.copyWith(isLoadingMore: false));
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchPage(1));
  }
}

final libraryProvider =
    AsyncNotifierProvider<LibraryNotifier, LibraryState>(LibraryNotifier.new);