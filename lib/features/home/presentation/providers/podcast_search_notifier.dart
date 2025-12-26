import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/features/home/data/models/podcast_model.dart';
import 'package:podcast_finder/features/home/data/repositories/podcast_repository.dart';

class PodcastSearchNotifier extends StateNotifier<AsyncValue<List<PodcastModel>>> {
  final PodcastRepository _repository;

  PodcastSearchNotifier(this._repository) : super(const AsyncValue.data([]));

  Future<void> search(String query) async {
    try {
      state = const AsyncValue.loading();
      final podcasts = await _repository.searchPodcasts(query: query);
      state = AsyncValue.data(podcasts);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
