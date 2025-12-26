import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/podcast_detail_model.dart';
import '../../data/repositories/podcast_detail_repository.dart';
import 'podcast_detail_notifier.dart';

final podcastDetailProvider = StateNotifierProvider.family<
    PodcastDetailNotifier,
    AsyncValue<PodcastDetailModel>,
    String>((ref, podcastId) {
  final repository = ref.read(podcastDetailRepositoryProvider);
  final notifier = PodcastDetailNotifier(repository);
  notifier.load(podcastId);
  return notifier;
});