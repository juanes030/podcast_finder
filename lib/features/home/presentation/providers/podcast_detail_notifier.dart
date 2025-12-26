import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/podcast_detail_model.dart';
import '../../data/repositories/podcast_detail_repository.dart';

class PodcastDetailNotifier
    extends StateNotifier<AsyncValue<PodcastDetailModel>> {
  final PodcastDetailRepository _repository;

  PodcastDetailNotifier(this._repository)
      : super(const AsyncValue.loading());

  Future<void> load(String podcastId) async {
    try {
      state = const AsyncValue.loading();
      final podcast = await _repository.getPodcastDetail(podcastId);
      state = AsyncValue.data(podcast);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}