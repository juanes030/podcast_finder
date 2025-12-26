import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/podcast_model.dart';
import '../../data/repositories/podcast_repository.dart';
import 'podcast_search_notifier.dart';

final podcastSearchProvider =
    StateNotifierProvider<PodcastSearchNotifier, AsyncValue<List<PodcastModel>>>(
  (ref) {
    final repository = ref.read(podcastRepositoryProvider);
    return PodcastSearchNotifier(repository);
  },
);