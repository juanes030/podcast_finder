import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:podcast_finder/core/utils/debouncer.dart';
import 'package:podcast_finder/features/home/presentation/providers/podcast_search_provider.dart';
import 'package:podcast_finder/features/home/presentation/widgets/podcast_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final Debouncer _debouncer =
      Debouncer(duration: const Duration(milliseconds: 500));

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(podcastSearchProvider.notifier).search('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final podcastsAsync = ref.watch(podcastSearchProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('PodcastFinder'),
      ),
      body: Column(
        children: [
          // Search input
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search podcasts...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                _debouncer(() {
                  ref.read(podcastSearchProvider.notifier).search(value);
                });
              },
            ),
          ),

          // Podcast list
          Expanded(
            child: podcastsAsync.when(
              data: (podcasts) {
                if (podcasts.isEmpty) {
                  return const Center(
                    child: Text('No podcasts found'),
                  );
                }
                return ListView.builder(
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
                        ref.read(podcastSearchProvider.notifier).search('');
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
