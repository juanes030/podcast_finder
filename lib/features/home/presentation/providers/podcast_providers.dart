import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/podcast_repository.dart';
import '../../data/models/podcast_model.dart';

// Provider del repositorio
final podcastRepositoryProvider = Provider((ref) => PodcastRepository());

// Provider que el Home escuchará (el listado)
final podcastsProvider = FutureProvider<List<PodcastModel>>((ref) async {
  final repo = ref.watch(podcastRepositoryProvider);
  return repo.fetchPodcasts();
});

// Provider para el detalle (guarda el podcast seleccionado)
final selectedPodcastProvider = StateProvider<PodcastModel?>((ref) => null);