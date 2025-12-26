import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/core/utils/date_formatter.dart';
import 'package:podcast_finder/core/utils/duration_formatter.dart';

import '../providers/podcast_detail_provider.dart';

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
              // 🎧 Podcast image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  podcast.image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,

                  // ⏳ Loader mientras carga la imagen
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

                  // ❌ Fallback si falla la imagen
                  errorBuilder: (_, __, ___) => Container(
                    height: 200,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.podcasts, size: 48),
                  ),
                ),
              ),


              const SizedBox(height: 16),

              // 📌 Title
              Text(
                podcast.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              const SizedBox(height: 4),

              // 🏢 Publisher
              Text(
                podcast.publisher,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey),
              ),

              const SizedBox(height: 16),

              // 📝 Description
              Text(
                podcast.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 24),

              // 🎙 Episodes title
              Text(
                'Episodes',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              // 🎧 Episodes list
              ...podcast.episodes.take(5).map(
                (episode) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    title: Text(episode.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),

                        // 📅 Fecha
                        Text(
                          DateFormatter.formatFromMilliseconds(
                            episode.publishDateMs,
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.grey),
                        ),

                        const SizedBox(height: 2),

                        // ⏱ Duración
                        Text(
                          DurationFormatter.formatFromSeconds(
                            episode.audioLengthSec,
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.grey),
                        ),

                        const SizedBox(height: 4),

                        // 📝 Descripción
                        Text(
                          episode.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
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
