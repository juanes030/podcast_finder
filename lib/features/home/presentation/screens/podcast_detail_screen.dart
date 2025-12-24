import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/podcast_detail_provider.dart';

class PodcastDetailScreen extends ConsumerWidget {
  final String podcastId;
  const PodcastDetailScreen({super.key, required this.podcastId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final podcastAsync = ref.watch(podcastDetailProvider(podcastId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Podcast Detail'),
        // Usamos AppColors para mantener la consistencia
        foregroundColor: AppColors.textPrimary, 
      ),
      body: podcastAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: AppColors.error))),
        data: (podcast) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Cabecera con Imagen Grande
              _buildHeader(podcast.imageUrl),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 2. Título del Podcast
                    Text(
                      podcast.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // 3. Autor / Publisher con estilo distintivo
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        podcast.publisher.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    const Divider(color: AppColors.surfaceVariant),
                    const SizedBox(height: 24),

                    // 4. Descripción
                    const Text(
                      'About this podcast',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      podcast.description ?? 'No description available.',
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.6, // Mayor interlineado para lectura
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String? imageUrl) {
    return Hero(
      tag: 'podcast-$podcastId', // Animación fluida desde la lista
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: const BoxDecoration(
          color: AppColors.surfaceVariant,
        ),
        child: CachedNetworkImage(
          imageUrl: imageUrl ?? '',
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: Icon(Icons.podcasts, size: 80, color: AppColors.textTertiary),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}