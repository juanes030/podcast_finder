import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/podcast_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/podcast_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final podcastsAsync = ref.watch(podcastsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('PodcastFinder'),
      ),
      body: Column(
        children: [
          // Search hint (not functional yet - candidates will implement)
          Container(
            padding: const EdgeInsets.all(16),
            child: const TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: 'Search podcasts...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: Tooltip(
                  message: 'This feature needs to be implemented',
                  child: Icon(
                    Icons.info_outline,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
          // Hardcoded list
          Expanded(
            child: podcastsAsync.when(
              data: (podcasts) => ListView.builder(
                itemCount: podcasts.length,
                itemBuilder: (context, index) {
                  final podcast = podcasts[index];
                  return PodcastCard(
                    podcast: podcast,
                    onTap: () {
                      context.pushNamed(
                        'detail',
                        pathParameters: {'id': podcast.id},
                      );
                    },
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}