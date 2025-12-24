import '../models/podcast_model.dart';

class PodcastRepository {
  Future<List<PodcastModel>> fetchPodcasts() async {
    await Future.delayed(const Duration(milliseconds: 800)); // Simula latencia
    return [
      const PodcastModel(
        id: 'hardcoded-1',
        title: 'The Daily Tech',
        publisher: 'Tech News Network',
        imageUrl: 'https://picsum.photos/seed/daily/200',
        description: 'Your source for daily technology news and updates.',
      ),
      const PodcastModel(
        id: 'hardcoded-2',
        title: 'Science Weekly',
        publisher: 'Science Publishers',
        imageUrl: 'https://picsum.photos/seed/science/200',
        description: 'Explore the latest discoveries in science and research.',
      ),
      const PodcastModel(
        id: 'hardcoded-3',
        title: 'Business Insights',
        publisher: 'Business Media Co',
        imageUrl: 'https://picsum.photos/seed/business/200',
        description: 'Deep dives into successful business strategies.',
      ),
    ];
  }
}