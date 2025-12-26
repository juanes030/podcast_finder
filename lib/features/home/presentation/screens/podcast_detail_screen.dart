import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/features/home/presentation/providers/podcast_detail_provider.dart';
import 'package:podcast_finder/features/home/presentation/widgets/episode_list_tile.dart';
class PodcastDetailScreen extends ConsumerWidget {
  final String podcastId;

  const PodcastDetailScreen({
    super.key,
    required this.podcastId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final podcastAsync = ref.watch(podcastDetailProvider(podcastId));

    return Scaffold(
      appBar: AppBar(),
      body: podcastAsync.when(
        data: (podcast) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  podcast.image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const SizedBox(
                      height: 200,
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2,),
                      ),
                    );
                  },
                  errorBuilder: (_, __, ___) => Container(
                    height: 200,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.podcasts, size: 48),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                podcast.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 4),
              Text(
                podcast.publisher,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Text(
                podcast.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              Text(
                'Episodes',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...podcast.episodes.take(5).map(
                (episode) => EpisodeListTile(
                  episode: episode,
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                error.toString(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  ref.read(podcastDetailProvider(podcastId).notifier).load(podcastId);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
